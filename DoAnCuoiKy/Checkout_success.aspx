<%@ Page Title="Đặt hàng thành công" Language="C#" MasterPageFile="~/eWorld.Master" AutoEventWireup="true" CodeBehind="Checkout_success.aspx.cs" Inherits="DoAnCuoiKy.Checkout_success" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Đặt hàng thành công. Xem lại thông tin đặt hàng tại Trang quản lý.</h2>
    <asp:Button runat="server" ID="back_to_default" Text="Trở về trang chủ" OnClick="back_to_cart_Click" CssClass="btn"/>
</asp:Content>
