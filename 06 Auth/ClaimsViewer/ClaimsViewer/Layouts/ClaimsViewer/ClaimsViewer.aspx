<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClaimsViewer.aspx.cs" Inherits="ClaimsViewer.Layouts.ClaimsViewer.ClaimsViewer" DynamicMasterPageFile="~masterurl/default.master" %>


<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
  <link rel="Stylesheet" type="text/css" href="ClaimsViewer.css" />
</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">

   <div id="top">

    <asp:GridView 
      ID="grdClaims" runat="server" AutoGenerateColumns="false" 
      CssClass="gridTable" RowStyle-Wrap="true" AlternatingRowStyle-Wrap="true" >
      <HeaderStyle CssClass="gridHeaderRow" />
      <RowStyle CssClass="gridRow" />
      <AlternatingRowStyle CssClass="gridAlternatingRow" />
      <Columns>
        <asp:BoundField DataField="ClaimType" HtmlEncode="false" HeaderText="Claim Type" ItemStyle-VerticalAlign="Top" />
        <asp:BoundField DataField="ClaimValue" HtmlEncode="false" HeaderText="Claim Value" ItemStyle-VerticalAlign="Top"  />
      </Columns>
    </asp:GridView>

    <asp:Label ID="status" runat="server" />

  </div>

</asp:Content>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
  Claims Viewer Demo - SAML Token for Current User
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
  SAML Token for Current User
</asp:Content>
