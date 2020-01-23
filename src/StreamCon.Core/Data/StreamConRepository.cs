using Microsoft.Extensions.Logging;
using StreamCon.Core.DataModels;
using System;
using System.Collections.Generic;
using System.Text;

namespace StreamCon.Core.Data
{
    public class StreamConRepository : IStreamConRepository
    {
        private readonly StreamConContext _ctx;
        private readonly ILogger<StreamConRepository> _logger;

        public StreamConRepository(StreamConContext ctx, ILogger<StreamConRepository> logger)
        {
            _ctx = ctx;
            _logger = logger;
        }

        public IEnumerable<DeviceHolder> GetAllDeviceHolders()
        {
            throw new NotImplementedException();
        }

        public IEnumerable<Device> GetAllDevices()
        {
            throw new NotImplementedException();
        }

        public Device GetDeviceBySerialNumber(string serialNumber)
        {
            throw new NotImplementedException();
        }

        public DeviceHolder GetDeviceHolderById(int id)
        {
            throw new NotImplementedException();
        }

        public void AddEntity(object model)
        {
            _ctx.Add(model);
        }
    }
}
