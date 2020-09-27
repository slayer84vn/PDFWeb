using Gmap.Code;
using System.Web;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System;

namespace Gmap.Model {

    public static class AuthHelper {
        public static tblUser SignIn(string userName, string password) {
            using (CHXD_MapEntities entities = new CHXD_MapEntities())
            {
                string passMd5 = GetMD5(password);
                tblUser user = entities.tblUsers.FirstOrDefault(z => z.UserName == userName && z.Pass == passMd5 && z.IsLock == false);
                HttpContext.Current.Session["User"] = user;
                if (user != null)
                {
                    HttpContext.Current.Session["UserName"] = user.UserName;
                    HttpContext.Current.Session["GroupID"] = user.GroupID;
                    //HttpContext.Current.Session["BranchID"] = user.BranchID;
                }
                return user;
            }
            
        }
        public static void SignOut() {
            HttpContext.Current.Session["User"] = null;
        }
        public static bool IsAuthenticated() {
            return GetLoggedInUserInfo() != null;
        }

        public static tblUser GetLoggedInUserInfo() {
            return HttpContext.Current.Session["User"] as tblUser;
        }

        public static string GetMD5(string str)
        {
            MD5CryptoServiceProvider md5 = new MD5CryptoServiceProvider();
            byte[] bHash = md5.ComputeHash(Encoding.UTF8.GetBytes(str));
            StringBuilder sbHash = new StringBuilder();
            foreach (byte b in bHash)
            {
                sbHash.Append(String.Format("{0:x2}", b));
            }
            return sbHash.ToString();
        }
    }
}