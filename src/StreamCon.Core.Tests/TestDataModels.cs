using Microsoft.VisualStudio.TestTools.UnitTesting;
using StreamCon.Core.DataModels;

namespace StreamCon.Core.Tests
{
    [TestClass]
    public class TestDataModels
    {
        [TestMethod]
        public void TestDevice()
        {
            var myClass = new Device();
            Assert.IsNotNull(myClass);
        }
    }
}
