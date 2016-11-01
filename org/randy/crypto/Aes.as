package org.randy.crypto
{
    import com.hurlant.crypto.symmetric.*;
    import com.hurlant.util.*;

    public class Aes extends Object
    {
        private var _pad:IPad;
        private var _mode:ICipher;

        public function Aes(param1:String)
        {
            this._pad = new PKCS5();
            var _loc_2:* = Base64.decodeToByteArray(param1);
            this._mode = new ECBMode(new AESKey(_loc_2), this._pad);
            this._pad.setBlockSize(this._mode.getBlockSize());
            return;
        }// end function

        public function encrypt(param1:String) : String
        {
            var _loc_2:* = Hex.toArray(Hex.fromString(param1));
            this._mode.encrypt(_loc_2);
            return Base64.encodeByteArray(_loc_2);
        }// end function

        public function decrypt(param1:String) : String
        {
            var _loc_2:* = Base64.decodeToByteArray(param1);
            this._mode.decrypt(_loc_2);
            return Base64.decode(Base64.encodeByteArray(_loc_2));
        }// end function

        public function dispose() : void
        {
            this._mode.dispose();
            this._mode = null;
            this._pad = null;
            return;
        }// end function

    }
}
