package io.cozy.plugins.authstorage;

import android.content.Context;
import android.content.SharedPreferences;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;

import io.cozy.drive.mobile.R;

public class AuthStorage extends CordovaPlugin {

    private Context mContext;

    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
        mContext = this.cordova.getActivity().getApplicationContext();
    }


    @Override
    public boolean execute(String action, final JSONArray args, final CallbackContext callbackContext) throws JSONException {
        if ("storeData".equals(action)) {
            cordova.getThreadPool().execute(new Runnable() {
                public void run() {
                    try {
                        storeData(callbackContext, args.getString(0), args.getString(1));
                    } catch (Exception e) {
                        e.printStackTrace();
                        callbackContext.error(e.getMessage());
                    }
                }
            });
            return true;
        }
        else if ("removeData".equals(action)) {
            cordova.getThreadPool().execute(new Runnable() {
                public void run() {
                    removeData(callbackContext);
                }
            });
            return true;
        }
        return false;
    }


    private void storeData(CallbackContext aCallbackContext, String aURL, String aToken) {

        // TODO encrypt !!
        SharedPreferences sp = mContext.getSharedPreferences(mContext.getString(R.string.preference_file_key), Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sp.edit();
        editor.putString("cozy_url", aURL);
        editor.putString("cozy_token", aToken);
        editor.commit();
        PluginResult pr = new PluginResult(PluginResult.Status.OK, "ok");
        aCallbackContext.sendPluginResult(pr);
    }


    private void removeData(CallbackContext aCallbackContext) {

        SharedPreferences sp = mContext.getSharedPreferences(mContext.getString(R.string.preference_file_key), Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sp.edit();
        editor.remove("cozy_url");
        editor.remove("cozy_token");
        editor.commit();
        PluginResult pr = new PluginResult(PluginResult.Status.OK, "ok");
        aCallbackContext.sendPluginResult(pr);
    }

}
