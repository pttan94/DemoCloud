<%@ Page Title="Lịch sử mua hàng" Language="C#" MasterPageFile="~/eWorld.Master" AutoEventWireup="true" CodeBehind="OrderHistory.aspx.cs" Inherits="DoAnCuoiKy.Account.OrderHistory" %>
<%@ Import Namespace="System.Globalization" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Lịch sử mua hàng</h1>
    <asp:GridView ID="OrderList" runat="server" AutoGenerateColumns="False" GridLines="Vertical" CellPadding="4"
        ItemType="DoAnCuoiKy.Order" SelectMethod="GetOrder"
        CssClass="table table-striped table-bordered">
        <Columns>
            <asp:BoundField DataField="OrderID" HeaderText="ID" SortExpression="OrderID" />
            <asp:TemplateField HeaderText="Khách hàng">
                <ItemTemplate>
                    <label id="Cus" runat="server"><%#: Item.Email.ToString() %></label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Ngày mua hàng">
                <ItemTemplate>
                    <label id="OrderDate" runat="server"><%#: Item.OrderDate.ToString() %></label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Tổng tiền">
                <ItemTemplate>
                    <%#: String.Format(CultureInfo.GetCultureInfo("vi-VN"),"{0:c0}", Convert.ToDouble(Item.Total))%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Tình trạng đơn hàng">
                <ItemTemplate>
                    <label id="isPaid" runat="server"><%#: Item.paid==true?"Đã thanh toán":"Chưa thanh toán" %></label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Xem chi tiết">
                <ItemTemplate>
                    <asp:LinkButton id="orderDetail" runat="server" OnClick="orderDetail_Click">Chi tiết đơn hàng</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <div style="text-align: center; font-size: 18px;">
        <asp:Label ID="Title_EmptyOrder" runat="server" Text="Bạn chưa mua sản phẩm nào tại cửa hàng" Visible="false"></asp:Label>
    </div>
</asp:Content>
