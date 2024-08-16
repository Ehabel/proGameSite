package usyd.elec5619.demo.ORDER;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import usyd.elec5619.demo.USER.User;

import java.math.BigDecimal;
import java.util.Date;

public class OrderDTO {

    @NotNull
    private Long id;

    @NotNull
    private User user;

    @NotNull
    private User proUser;

    @NotNull
    private Date orderDate;

    @NotNull
    private BigDecimal amount;

    @NotNull
    private Order.OrderStatus status = Order.OrderStatus.PENDING;

    @NotNull
    private Double quantity;


    public OrderDTO(Long id, User user, User proUser, Date orderDate, BigDecimal amount, Double quantity,Order.OrderStatus status) {
        this.id = id;
        this.user = user;
        this.proUser = proUser;
        this.orderDate = orderDate;
        this.amount = amount;
        this.quantity = quantity;
        this.status = status;
    }

    public OrderDTO() {}


    public Long getOrderId() {
        return id;
    }

    public void setOrderId(Long orderId) {
        this.id = orderId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public User getProUser() {
        return proUser;
    }

    public void setProUser(User proUser) {
        this.proUser = proUser;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public Double getQuantity() {
        return quantity;
    }

    public void setQuantity(Double quantity) {
        this.quantity = quantity;
    }

    public void setStatus(Order.OrderStatus status){this.status = status;}

    public Order.OrderStatus getStatus() {
        return status;
    }
}