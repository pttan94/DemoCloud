<%@ Page Title="Quản lý đơn hàng" Language="C#" MasterPageFile="~/eWorld.Master" AutoEventWireup="true" CodeBehind="Admin_order.aspx.cs" Inherits="DoAnCuoiKy.Admin.Admin_order" %>
<%@ Import Namespace="System.Globalization" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

      <asp:GridView ID="OrderList" runat="server" AutoGenerateColumns="False" GridLines="Vertical" CellPadding="4"
        ItemType="DoAnCuoiKy.Order" SelectMethod="GetOrder"
        CssClass="table table-striped table-bordered">
        <Columns>
            <asp:BoundField DataField="OrderID" HeaderText="ID" SortExpression="OrderID" />
            <asp:BoundField DataField="Email" HeaderText="Khách hàng" />
            <asp:BoundField DataField="OrderDate" HeaderText="Ngày mua hàng" />

            <asp:TemplateField HeaderText="Tổng tiền">
                <ItemTemplate>
                    <%#: String.Format(CultureInfo.GetCultureInfo("vi-VN"),"{0:c0}", Convert.ToDouble(Item.Total))%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Đã thanh toán?" >
                <ItemTemplate>
                    <asp:DropDownList ID="order_status" runat="server" SelectMethod="status_order" AutoPostBack="True"  OnSelectedIndexChanged="order_status_SelectedIndexChanged"/>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Xem chi tiết">
                <ItemTemplate>
                    <asp:LinkButton id="orderDetail" runat="server" OnClick="orderDetail_Click">Chi tiết đơn hàng</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
 
</asp:Content>
