package com.snake.formatters
{
    public class DateInfo 
    {

        public var dayNamesLong:Array;
        public var dayNamesShort:Array;
        public var monthNamesLong:Array;
        public var monthNamesShort:Array;
        public var timeOfDay:Array;
        public var todayNames:Array;
        public var time:String = "h:mm:ss A";
        public var dateLong:String = "EEEE, MMMM dd, YYYY";
        public var dateShort:String = "M/d/YYYY";

        public function DateInfo()
        {
            this.dayNamesLong = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
            this.dayNamesShort = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
            this.monthNamesLong = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
            this.monthNamesShort = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
            this.timeOfDay = ["AM", "PM"];
            this.todayNames = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31];
            super();
        }

    }
}//package com.snake.formatters
