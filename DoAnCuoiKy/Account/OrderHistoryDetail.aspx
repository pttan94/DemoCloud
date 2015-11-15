<%@ Page Title="Chi tiết đơn hàng" Language="C#" MasterPageFile="~/eWorld.Master" AutoEventWireup="true" CodeBehind="OrderHistoryDetail.aspx.cs" Inherits="DoAnCuoiKy.Account.OrderHistoryDetail" %>
<%@ Import Namespace="System.Globalization" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

      <asp:GridView ID="OrderDetail" runat="server" AutoGenerateColumns="False" GridLines="Vertical" CellPadding="4"
        ItemType="DoAnCuoiKy.OrderDetail" SelectMethod="GetOrderDetail"
        CssClass="table table-striped table-bordered">
        <Columns>
            <asp:BoundField DataField="OrderID" HeaderText="ID" />
            <asp:TemplateField HeaderText="Sản phẩm">
                <ItemTemplate>
                    <label id="product" runat="server"><%#: Item.Product.ProductName %></label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Quantity" HeaderText="Số lượng" />

            <asp:TemplateField HeaderText="Đơn giá">
                <ItemTemplate>
                    <%#: String.Format(CultureInfo.GetCultureInfo("vi-VN"),"{0:c0}", Convert.ToDouble(Item.UnitPrice))%>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

</asp:Content>
