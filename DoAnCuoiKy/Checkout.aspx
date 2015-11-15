<%@ Page Title="Xác nhận" Language="C#" MasterPageFile="~/eWorld.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="DoAnCuoiKy.Checkout" %>

<%@ Import Namespace="System.Globalization" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:GridView ID="Checkout_CartList" runat="server" AutoGenerateColumns="False" GridLines="Vertical" CellPadding="4"
        ItemType="DoAnCuoiKy.Cart" SelectMethod="GetShoppingCartItems"
        CssClass="table table-striped table-bordered">
        <Columns>
            <asp:BoundField DataField="ProductID" HeaderText="ID" SortExpression="ProductID" />
            <asp:TemplateField HeaderText="Sản phẩm">
                <ItemTemplate>
                    <a id="ProductName" href="Product?ProductID=<%#Item.ProductID%>"><%# Item.Product.ProductName %></a>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Đơn giá">
                <ItemTemplate>
                    <%#: String.Format(CultureInfo.GetCultureInfo("vi-VN"),"{0:c0}", Convert.ToDouble(Item.Product.Price))%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Số lượng">
                <ItemTemplate>
                    <asp:Label ID="PurchaseQuantity" runat="server" Text="<%#: Item.Quantity %>"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Thành tiền">
                <ItemTemplate>
                    <%#: String.Format(CultureInfo.GetCultureInfo("vi-VN"),"{0:c0}", ((Convert.ToDouble(Item.Quantity)) *  Convert.ToDouble(Item.Product.Price)))%>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:Label ID="LabelTotalText" runat="server" Text="Tổng tiền: " Font-Size="Medium"></asp:Label>
    <asp:Label ID="lblTotal" runat="server" EnableViewState="false" Font-Size="Medium"></asp:Label><br /><br />
    <asp:Label ID="type_paid" runat="server" Text="Hình thức thanh toán: Giao hành" Font-Size="Medium"></asp:Label>
    <br /><br />
    <span>
    <asp:Button runat="server" ID="submit" Text="submit" OnClick="submit_Click" CssClass="btn"/>
    <asp:Button runat="server" ID="cancel" Text="Cancel" OnClick="cancel_Click" CssClass="btn" />
        </span>
</asp:Content>
