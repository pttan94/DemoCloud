<%@ Page Title="Quản lý thông tin cá nhân" Language="C#" MasterPageFile="~/eWorld.Master" AutoEventWireup="true" CodeBehind="Manage.aspx.cs" Inherits="DoAnCuoiKy.Account.Manage" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>

    <div>
        <asp:PlaceHolder runat="server" ID="successMessage" Visible="false" ViewStateMode="Disabled">
            <p class="text-success"><%: SuccessMessage %></p>
        </asp:PlaceHolder>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="form-horizontal">
                
                <hr />
                <dl class="dl-horizontal">
                    <dt>Tên người dùng</dt>
                    <dd>
                        <asp:Label Text="" ID="UserName" runat="server" />
                    </dd>
                    <dt>Mật khẩu:</dt>
                    <dd>
                        <asp:HyperLink NavigateUrl="/Account/ManagePassword" Text="[Thay đổi]" Visible="false" ID="ChangePassword" runat="server" />
                        <!--<asp:HyperLink NavigateUrl="/Account/ManagePassword" Text="[Tạo mới]" Visible="false" ID="CreatePassword" runat="server" />-->
                    </dd>
                    <!--
                    <dt>External Logins:</dt>
                    <dd><%: LoginsCount %>
                        <asp:HyperLink NavigateUrl="/Account/ManageLogins" Text="[Manage]" runat="server" />

                    </dd>
                    -->
                    <%--
                        Phone Numbers can used as a second factor of verification in a two-factor authentication system.
                        See <a href="http://go.microsoft.com/fwlink/?LinkId=403804">this article</a>
                        for details on setting up this ASP.NET application to support two-factor authentication using SMS.
                        Uncomment the following blocks after you have set up two-factor authentication
                    --%>
                    
                    <dt>Số điện thoại:</dt>
                    <% if (HasPhoneNumber)
                       { %>
                    <dd>
                        <asp:HyperLink NavigateUrl="/Account/AddPhoneNumber" runat="server" Text="[Thêm]" />
                    </dd>
                    <% }
                       else
                       { %>
                    <dd>
                        <asp:Label Text="" ID="PhoneNumber" runat="server" />
                        <asp:HyperLink NavigateUrl="/Account/AddPhoneNumber" runat="server" Text="[Thay đổi]" /> &nbsp;|&nbsp;
                        <asp:LinkButton Text="[Xóa]" OnClick="RemovePhone_Click" runat="server" />
                    </dd>
                    <% } %>
                    <!--
                    <dt>Two-Factor Authentication:</dt>
                    <dd>
                        <p>
                            There are no two-factor authentication providers configured. See <a href="http://go.microsoft.com/fwlink/?LinkId=403804">this article</a>
                            for details on setting up this ASP.NET application to support two-factor authentication.
                        </p>
                        <% if (TwoFactorEnabled)
                          { %> 
                        <%--
                        Enabled
                        <asp:LinkButton Text="[Disable]" runat="server" CommandArgument="false" OnClick="TwoFactorDisable_Click" />
                        --%>
                        <% }
                          else
                          { %> 
                        <%--
                        Disabled
                        <asp:LinkButton Text="[Enable]" CommandArgument="true" OnClick="TwoFactorEnable_Click" runat="server" />
                        --%>
                        <% } %>
                    </dd>-->
                    <dt>Lịch sử mua hàng</dt>
                    <dd>
                        <asp:HyperLink ID="order_history" NavigateUrl="/Account/OrderHistory" runat="server" Text="Xem lịch sử mua hàng"  />
                    </dd>
                   

                    
                </dl>
            </div>
        </div>
    </div>

</asp:Content>
