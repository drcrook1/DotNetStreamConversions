using System;
using System.Collections.Generic;
using System.Text;

namespace StreamCon.Core.DataModels
{
    public class TelemetryReading
    {
        public float ValueA { get; set; }
        public float ValueB { get; set; }
        public DateTime LastReadingUTC { get; set; }
    }
}
