using Microsoft.EntityFrameworkCore;
using StreamCon.Core.DataModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace StreamCon.Core.Data
{
    public class StreamConContext : DbContext
    {
        public StreamConContext(DbContextOptions<StreamConContext> options) : base(options)
        {
        }

        public DbSet<Device> Devices { get; set; }
        public DbSet<DeviceHolder> DeviceHolders { get; set; }
    }
}
