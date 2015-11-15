using DoAnCuoiKy.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DoAnCuoiKy.Logic
{
    internal class RoleActions
    {
        internal void AddUserAndRole()
        {
            Models.ApplicationDbContext db = new ApplicationDbContext();
            IdentityResult IdRoleResult;
            IdentityResult IdUserResult;

            var roleStore = new RoleStore<IdentityRole>(db);

            var roleMgr = new RoleManager<IdentityRole>(roleStore);

            if (!roleMgr.RoleExists("canEdit"))
            {
                IdRoleResult = roleMgr.Create(new IdentityRole { Name = "canEdit" });
            }

            var userMgr = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(db));
            var appUser = new ApplicationUser
            {
                UserName = "pttan@gmail.com",
                Email = "pttan@gmail.com"
            };
            IdUserResult = userMgr.Create(appUser, "Thanhtan1310*");

            if (!userMgr.IsInRole(userMgr.FindByEmail("pttan@gmail.com").Id, "canEdit"))
            {
                IdUserResult = userMgr.AddToRole(userMgr.FindByEmail("pttan@gmail.com").Id, "canEdit");
            }
        }
    }
}