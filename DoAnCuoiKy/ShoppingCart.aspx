<%@ Page Title="Giỏ hàng" Language="C#" EnableEventValidation="false" MasterPageFile="~/eWorld.Master" AutoEventWireup="true" CodeBehind="ShoppingCart.aspx.cs" Inherits="DoAnCuoiKy.ShoppingCart" %>

<%@ Import Namespace="System.Globalization" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div id="Content">
        <div class="space"></div>
        <div class="breadcrumb">
            <a href="/Default.aspx">Trang chủ</a> &gt; <a href="/ShoppingCart.aspx">Giỏ hàng</a>
        </div>
        <!--start-->
        <h2 id="cart_title">Giỏ hàng của bạn</h2>
        <label id="status_quan" runat="server"></label>
        <!--<label id="status_checkout" runat="server"></label>-->
       
        <div id="cartForm">
            <div class="CartContents" style="margin-bottom:20px;">
                <asp:GridView ID="CartList" runat="server" AutoGenerateColumns="False" GridLines="Vertical" CellPadding="4"
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
                                <asp:TextBox ID="PurchaseQuantity" Width="40" runat="server" Text="<%#: Item.Quantity %>"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Thành tiền">
                            <ItemTemplate>
                                <%#: String.Format(CultureInfo.GetCultureInfo("vi-VN"),"{0:c0}", ((Convert.ToDouble(Item.Quantity)) *  Convert.ToDouble(Item.Product.Price)))%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Xóa">
                            <ItemTemplate>
                                <asp:CheckBox ID="Remove" runat="server"></asp:CheckBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>

                <asp:Label ID="LabelTotalText" runat="server" Text="Tổng tiền: " Font-Size="Medium"></asp:Label>
                <asp:Label ID="lblTotal" runat="server" EnableViewState="false" Font-Size="Medium"></asp:Label>
                <div style="text-align: center; font-size: 18px;">
                    <asp:Label ID="Title_EmptyCart" runat="server" Text="Không có sản phẩm nào trong giỏ hàng" Visible="false"></asp:Label>
                </div>
            </div>
            <span class="CartUpdateBtn">
                <asp:Button ID="Update_btn" runat="server" Text="Cập nhật" CssClass="btn" OnClick="Update_btn_Click" />
                <asp:Button ID="Checkout_btn" runat="server" Text="Thanh toán" CssClass="btn" OnClick="Checkout_btn_Click" />
            </span>


        </div>


        <!--end-->
        <div class="clearfix"></div>
    </div>


</asp:Content>
