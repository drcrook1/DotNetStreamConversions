using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using StreamCon.Core.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace StreamCon.Apis.Controllers
{
    [Route("api/v1/[Controller]")]
    public class DevicesController : Controller
    {
        private readonly IStreamConRepository _repo;
        private readonly ILogger<DevicesController> _logger;

        public DevicesController(IStreamConRepository repo, ILogger<DevicesController> logger)
        {
            _repo = repo;
            _logger = logger;
        }

        [HttpGet]
        public IActionResult Get()
        {
            try
            {
                var results = _repo.GetAllDevices();
                return Ok(results);
            }
            catch(Exception ex)
            {
                _logger.LogError($"Failed to get devices: {ex}");
                return BadRequest("Failed to get devices");
            }
        }
    }
}
