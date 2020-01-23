using StreamCon.Core.DataModels;
using System;
using System.Collections;
using System.Collections.Generic;

namespace StreamCon.Core.DataModels
{
    public class Device
    {
        public string SerialNumber { get; set; }
        public IEnumerable<String> Tags { get; set; }
        public TelemetryReading LatestReading { get; set; }
    }
}
