<%@ Page Title="Quản lý sản phẩm" Language="C#" MasterPageFile="~/eWorld.Master" AutoEventWireup="true" CodeBehind="Admin_product.aspx.cs" Inherits="DoAnCuoiKy.Admin.Admin_product" %>
<%@ Import Namespace="System.Globalization" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .float_ri {float:right;}
    </style>

    <div class="space"></div>
    <asp:HyperLink runat="server" ID="back_admin" NavigateUrl="~/Admin/AdminPage.aspx">Quay về trang quản lý</asp:HyperLink>

    <div class="clearfix">
        <div class="space"></div>
        <asp:Button runat="server" ID="add_product" CssClass="float_ri btn" OnClick="add_product_Click"  Text="Thêm sản phẩm" /><br /><br /><br />
        <asp:GridView ID="ProductList" runat="server" AutoGenerateColumns="False" GridLines="Vertical" CellPadding="4"
            ItemType="DoAnCuoiKy.Product" CssClass="table table-striped table-bordered">
            <Columns>
                <asp:BoundField DataField="ProductID" HeaderText="ID" SortExpression="ProductID" />
                <asp:BoundField DataField="ProductName" HeaderText="Tên sản phẩm" />
                <asp:TemplateField HeaderText="Hình ảnh">
                    <ItemTemplate>
                        <img width="300" src="/style/image/<%#: Item.ImagePath1%>" ID="pro_img1"/>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Giá">
                    <ItemTemplate>
                        <%#: String.Format(CultureInfo.GetCultureInfo("vi-VN"),"{0:c0}", Convert.ToDouble(Item.Price))%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Hiển thị">
                    <ItemTemplate>
                        <%# Item.Show == true? "Hiển thị":"Không hiển thị"%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Xem chi tiết">
                    <ItemTemplate>
                        <asp:LinkButton ID="ProDetail" runat="server" OnClick="ProDetail_Click">Xem/Sửa</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            
        </asp:GridView>
    </div>
</asp:Content>
