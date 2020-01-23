using StreamCon.Core.DataModels;
using System;
using System.Collections.Generic;
using System.Text;

namespace StreamCon.Core.Data
{
    public interface IStreamConRepository
    {
        IEnumerable<Device> GetAllDevices();
        IEnumerable<DeviceHolder> GetAllDeviceHolders();
        DeviceHolder GetDeviceHolderById(int id);
        Device GetDeviceBySerialNumber(string serialNumber);
        void AddEntity(object model);
    }
}
