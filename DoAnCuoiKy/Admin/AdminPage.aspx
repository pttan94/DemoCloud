<%@ Page Title="Admin" Language="C#" MasterPageFile="~/eWorld.Master" AutoEventWireup="true" CodeBehind="AdminPage.aspx.cs" Inherits="DoAnCuoiKy.Admin.AdminPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .ul_ad {list-style-type:none;margin-left:20px;}
        .li_ad {padding:5px 0;font-size:16px;}
    </style>
    <h1>Trang quản lý</h1>
    <hr />
    <ul class="ul_ad">
        <li class="li_ad"><asp:HyperLink runat="server" ID="link_cate" NavigateUrl="~/Admin/Admin_category.aspx">Quản lý nhóm sản phẩm</asp:HyperLink></li>
        <li class="li_ad"><asp:HyperLink runat="server" ID="link_prod" NavigateUrl="~/Admin/Admin_product.aspx">Quản lý sản phẩm</asp:HyperLink></li>
        <li class="li_ad"><asp:HyperLink runat="server" ID="link_acc" NavigateUrl="~/Admin/Admin_account.aspx">Quản lý người dùng</asp:HyperLink></li>
        <li class="li_ad"><asp:HyperLink runat="server" ID="link_order" NavigateUrl="~/Admin/Admin_order.aspx">Quản lý đơn hàng</asp:HyperLink></li>
        <li class="li_ad"><asp:HyperLink runat="server" ID="link_general" NavigateUrl="~/Admin/Admin_general.aspx">Quản lý chung</asp:HyperLink></li>
    </ul>

</asp:Content>
