package usyd.elec5619.demo.ORDER;

import jakarta.persistence.*;
import usyd.elec5619.demo.USER.User;
import java.math.BigDecimal;
import java.util.Date;



@Entity
@Table(name = "orders")
public class Order {

    public enum OrderStatus {
        PENDING,
        ACCEPTED,
        DECLINED,

    }
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;


    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name = "pro_user_id", nullable = false)
    private User proUser;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(nullable = false)
    private Date orderDate;

    @Column(nullable = false)
    private BigDecimal amount;

    @Column(nullable = false)
    private Double quantity;

    @Enumerated(EnumType.STRING)
    private OrderStatus status = OrderStatus.PENDING;
    
    public Order(Long id, User user, User proUser, Date orderDate, BigDecimal amount, Double quantity,OrderStatus status) {
        this.id = id;
        this.user = user;
        this.proUser = proUser;
        this.orderDate = orderDate;
        this.amount = amount;
        this.quantity = quantity;
        this.status = status;

    }

    public Order() {
    }


    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
    public Long getOrder_id() {
        return id;
    }

    public void setOrder_id(Long order_id) {
        this.id = order_id;
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

    public void setStatus(OrderStatus status) {
        this.status = status;
    }
    public OrderStatus getStatus(){
        return this.status;
    }

}
