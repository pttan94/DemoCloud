using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(DoAnCuoiKy.Startup))]
namespace DoAnCuoiKy
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
