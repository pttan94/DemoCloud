<%@ Page Title="Quản lý nhóm sản phẩm" Language="C#" MasterPageFile="~/eWorld.Master" AutoEventWireup="true" CodeBehind="Admin_category.aspx.cs" Inherits="DoAnCuoiKy.Admin.Admin_category" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="space"></div>
    <div>
        <asp:HyperLink runat="server" ID="back_admin" NavigateUrl="~/Admin/AdminPage.aspx">Quay về trang quản lý</asp:HyperLink>
        <div class="space"></div>
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
            <h1>Thêm nhóm sản phẩm</h1>
            <asp:Label runat="server" ID="add_cat_status"></asp:Label>
            <div>
                <p>Tên: </p>
                <asp:TextBox runat="server" ID="add_name_cat"></asp:TextBox>
                <asp:RequiredFieldValidator
                    ID="valid_add_name" runat="server"
                    Text="Tên nhóm không được để trống" ControlToValidate="add_name_cat"
                    SetFocusOnError="true" Display="Dynamic"
                    ValidationGroup="addGroup"></asp:RequiredFieldValidator>

                <br /><br /><br />
                <asp:Button runat="server" ID="add_cat"
                    Text="Thêm" OnClick="add_cat_Click"
                    CausesValidation="true" ValidationGroup="addGroup" />
            </div>
        </div>
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
            <h1>Chỉnh sửa nhóm sản phẩm</h1>
            <asp:Label runat="server" ID="update_cat_status"></asp:Label>
            <asp:Label runat="server" ID="delate_cat_status"></asp:Label>
            <div>
                <p>Chọn nhóm: </p>
                <asp:DropDownList runat="server" ID="list_cat"
                    ItemType="DoAnCuoiKy.Category"
                    DataTextField="Name"
                    DataValueField="CategoryID">
                </asp:DropDownList>
                <br /><br />
                <p>Tên mới: </p>
                <asp:TextBox runat="server" ID="new_name_cat"></asp:TextBox>
                <asp:RequiredFieldValidator
                    ID="valid_update_name" runat="server"
                    Text="Từ khóa không được để trống" ControlToValidate="new_name_cat"
                    SetFocusOnError="true" Display="Dynamic"
                    ValidationGroup="editGroup"></asp:RequiredFieldValidator>


                <br /><br /><br />
                <asp:Button runat="server" ID="update_cat" Text="Sửa" OnClick="update_cat_Click"
                    CausesValidation="true" ValidationGroup="editGroup" />
                <asp:Button runat="server" ID="del_cat" Text="Xóa" OnClick="del_cat_Click" />
            </div>
        </div>


    </div>
</asp:Content>
