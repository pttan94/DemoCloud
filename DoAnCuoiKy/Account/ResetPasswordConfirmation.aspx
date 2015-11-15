<%@ Page Title="Đổi mật khẩu" Language="C#" MasterPageFile="~/eWorld.Master" AutoEventWireup="true" CodeBehind="ResetPasswordConfirmation.aspx.cs" Inherits="DoAnCuoiKy.Account.ResetPasswordConfirmation" Async="true" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <h2><%: Title %>.</h2>
    <div>
        <p>Mật khẩu của bạn đã được thay đổi. Nhấp <asp:HyperLink ID="login" runat="server" NavigateUrl="~/Account/Login">here</asp:HyperLink> để đăng nhập </p>
    </div>
</asp:Content>
