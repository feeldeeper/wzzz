package modules.gamePlatform.model
{
    import flash.utils.*;
    import com.hurlant.crypto.symmetric.*;
    import com.hurlant.util.*;
    import com.hurlant.crypto.*;

    public class FrameHashModel 
    {

        private var type:String = "simple-des-ecb";
        private var key:ByteArray;

        public function FrameHashModel(_arg1:String)
        {
            this.key = Hex.toArray(Hex.fromString(_arg1));
        }

        public function decrypt(_arg1:String=""):String
        {
            var _local2:ByteArray;
            var _local3:IPad;
            var _local4:ICipher;
            try
            {
                _local2 = Base64.decodeToByteArray(_arg1);
                _local3 = new PKCS5();
                _local4 = Crypto.getCipher(this.type, this.key, _local3);
                _local3.setBlockSize(_local4.getBlockSize());
                _local4.decrypt(_local2);
                return (Hex.toString(Hex.fromArray(_local2)));
            }
            catch(e:Error)
            {
            };
            return ("false");
        }

        public function encrypt(_arg1:String=""):String
        {
            var _local2:ByteArray = Hex.toArray(Hex.fromString(_arg1));
            var _local3:IPad = new PKCS5();
            var _local4:ICipher = Crypto.getCipher(this.type, this.key, _local3);
            _local3.setBlockSize(_local4.getBlockSize());
            _local4.encrypt(_local2);
            return (Base64.encodeByteArray(_local2));
        }


    }
}//package modules.gamePlatform.model
