<%@ Page Title="Cài đặt chung" Language="C#" MasterPageFile="~/eWorld.Master" AutoEventWireup="true" CodeBehind="Admin_general.aspx.cs" Inherits="DoAnCuoiKy.Admin.Admin_general" %>

<%--<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>--%>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
   
     <div class="space"></div>
    <asp:HyperLink runat="server" ID="back_admin" NavigateUrl="~/Admin/AdminPage.aspx">Quay về trang quản lý</asp:HyperLink>
    <div class="space"></div>

    <h1>Menu trang chủ</h1>
    <asp:Label runat="server" Text="Chọn nhóm sản phẩm hiển thị ở trang chủ" />
    <asp:CheckBoxList ID="MenuCategory" DataValueField="CategoryID" DataTextField="Name" runat="server" ></asp:CheckBoxList>
    <asp:Button runat="server" Text="Lưu" ID="save_cateMenu" OnClick="save_cateMenu_Click" />

    <div class="space"></div>
    <h1>Slide</h1>
    <asp:FileUpload runat="server" ID="slide" AllowMultiple="true" /><br />
    <asp:Button runat="server" ID="submit_slide" Text="Upload" OnClick="submit_slide_Click" />
    <asp:Label runat="server" ID="list_upload_slide"></asp:Label>

    <div class="space"></div>
    <h1>Banner Quảng cáo</h1>
    <asp:FileUpload runat="server" ID="banner" AllowMultiple="true" />
    <br />
    <!--onchange="ShowImagePreview(this);"-->
    <!--<asp:Image ID="ImgPrv" Height="150px" Width="240px" runat="server" /><br />-->
    <div id="image_preview"></div>
    <asp:Button runat="server" ID="submit_banner" Text="Tải lên" OnClick="submit_banner_Click" />
    <asp:Label runat="server" ID="listofuploadedfiles"></asp:Label>

    <div class="space"></div>
    <h1>Thông tin cửa hàng</h1>

    <h3>Thông tin liên lạc</h3>

    <h3>Trung tâm bảo hành</h3>

    <h3>Hệ thống của hàng</h3>
    <asp:Button runat="server" Text="Lưu" ID="save_info" OnClick="save_info_Click" />

    <script type="text/javascript">
        function ShowImagePreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%=ImgPrv.ClientID%>').prop('src', e.target.result)
                        .width(240)
                        .height(150);
                };
                reader.readAsDataURL(input.files[0]);
                }
            }
    </script>
</asp:Content>

