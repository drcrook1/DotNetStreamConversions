using System;
using System.Collections.Generic;
using System.Text;

namespace StreamCon.Core.DataModels
{
    public class DeviceHolder
    {
        public List<Device> Devices;
        public string Name { get; set; }
        public string Id { get; set; }
    }
}