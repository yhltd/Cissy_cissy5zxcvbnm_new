<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="test.aspx.cs" Inherits="Web.test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table runat="server" id="table1">
                <tr>
                    <td>id:</td>
                    <td>
                        <asp:TextBox ID="tbId" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>name:</td>
                    <td>
                        <asp:TextBox ID="tbName" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>age:</td>
                    <td>
                        <asp:TextBox ID="tbAge" runat="server"></asp:TextBox>
                    </td>
                </tr>


                <tr>
                    <td>
                        <asp:Button runat="server" ID="BtnAdd" Text="add" OnClick="BtnAdd_Click" /></td>
                    <td>
                        <asp:Button runat="server" ID="BtnDel" Text="del" OnClick="BtnDel_Click" /></td>
                    <td>
                        <asp:Button runat="server" ID="BtnUpdate" Text="update" OnClick="BtnUpdate_Click" /></td>
                    <td>
                        <asp:Button runat="server" ID="BtnSelect" Text="select" OnClick="BtnSelect_Click" /></td>
                </tr>
            </table>
        </div>

    <div>
        <table>
            <tr>
                <td>

                </td>
            </tr>
        </table>
    </div>
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="SqlDataSource1" Height="232px" style="margin-top: 0px" Width="141px" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
            <Columns>
                <asp:BoundField DataField="id" HeaderText="序号" InsertVisible="False" ReadOnly="True" SortExpression="id" />
                <asp:BoundField DataField="name" HeaderText="姓名" SortExpression="name" />
                <asp:BoundField DataField="age" HeaderText="年龄" SortExpression="age" />
            </Columns>
            <FooterStyle BackColor="White" ForeColor="#000066" />
            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
            <RowStyle ForeColor="#000066" />
            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#007DBB" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#00547E" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:testConnectionString %>" SelectCommand="SELECT * FROM [aaa]"></asp:SqlDataSource>
    </form>

    </body>
</html>
