using System;
using System.Collections.Generic;
using System.Linq;
using System.Security;
using System.Security.Principal;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

using Microsoft.IdentityModel;
using Microsoft.IdentityModel.Claims;

using Microsoft.SharePoint;
using Microsoft.SharePoint.Utilities;
using Microsoft.SharePoint.WebControls;
using Microsoft.SharePoint.WebPartPages;

namespace ClaimsViewer.Layouts.ClaimsViewer {

  class ClaimTypeListItem {
    public string ClaimType { get; set; }
    public string ClaimValue { get; set; }
  }

  public partial class ClaimsViewer : LayoutsPageBase {

    protected override void OnPreRender(EventArgs e) {
        var UserClaims = new List<ClaimTypeListItem>();
        var identity = Page.User.Identity;

        if (identity is IClaimsIdentity)
        {
            var claimsIdentity = (IClaimsIdentity) identity;
            foreach (var claim in claimsIdentity.Claims)
            {
                UserClaims.Add(
                    new ClaimTypeListItem
                    {
                        ClaimType = "<div>" + claim.ClaimType + "</div>",
                        ClaimValue = "<div>" + claim.Value.Replace(",", ",<br/>") + "</div>"
                    });
            }
        }
        grdClaims.DataSource = UserClaims.OrderBy(claim => claim.ClaimType);
        grdClaims.DataBind();
    }
  }
}
