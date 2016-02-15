<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<t:layout title="List of Customers">

    <jsp:attribute name="body_area">
        <h3 align="center">List of Customers</h3>
        <table class="table table-striped table-bordered">
            <tr>
                <th>Id
                <th>Name
                <th>Address
                <th>Email
                <th>CCNo
                <th>CCType
            </tr>
            <c:forEach items="${customerList}" var="customer">
                <tr>
                    <td><c:out value="${customer.getId()}"/></td>
                    <td><c:out value="${customer.getName()}"/></td>
                    <td><c:out value="${customer.getAddress()}"/></td>
                    <td><c:out value="${customer.getEmail()}"/></td>
                    <td><c:out value="${customer.getCcNo()}"/></td>
                    <td><c:out value="${customer.getCcType()}"/></td>
                </tr>
            </c:forEach>
        </table>
    </jsp:attribute>
</t:layout>

