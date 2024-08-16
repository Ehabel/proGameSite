package usyd.elec5619.demo.ORDER;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import usyd.elec5619.demo.USER.User;
import usyd.elec5619.demo.USER.UserService;


import java.util.ArrayList;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class OrderService {
    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private UserService userService;

    @Autowired
    private ModelMapper modelMapper;

    private Date date;

    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }

    public Optional<Order> getOrderById(Long id) {
        return orderRepository.findById(id);
    }

    public Order saveOrder(Order order) {
        return orderRepository.save(order);
    }

    public void deleteOrder(Long id) {
        orderRepository.deleteById(id);
    }

    public void createOrder(OrderDTO orderDto) {
    }


    public List<OrderDTO> findOrdersByStatus(Order.OrderStatus pending) {
        List<Order> orders = getAllOrders();
        List<OrderDTO> dto = new ArrayList<>();
        for(Order o : orders){
            if(o.getStatus().equals(Order.OrderStatus.PENDING)){
                dto.add(new OrderDTO(o.getOrder_id(),o.getUser(),o.getProUser(),o.getOrderDate(),o.getAmount(),o.getQuantity(),o.getStatus()));
            }
        }
        return dto;
    }

    
    public Optional<OrderDTO> findById(Long orderId) {
        Optional<Order> orderOptional = orderRepository.findById(orderId);

        if (orderOptional.isPresent()) {
            Order order = orderOptional.get();
            OrderDTO dto = new OrderDTO(
                    order.getOrder_id(),
                    order.getUser(),
                    order.getProUser(),
                    order.getOrderDate(),
                    order.getAmount(),
                    order.getQuantity(),
                    order.getStatus()
            );
            return Optional.of(dto);
        } else {
            return Optional.empty();
        }
    }

    public void delete(OrderDTO orderDTO) {
        Order order = convertToEntity(orderDTO);
        orderRepository.delete(order);
    }

    public void save(OrderDTO orderDTO) {
        Order order = convertToEntity(orderDTO);
        orderRepository.save(order);
    }

    private Order convertToEntity(OrderDTO o) {
        return new Order(o.getOrderId(), o.getUser(), o.getProUser(), o.getOrderDate(), o.getAmount(), o.getQuantity(), o.getStatus());
    }

    public Order addToCart(String userEmail, int proUserId) {
        User user = userService.findByEmailTwo(userEmail).get();
        User proUser = userService.findById(proUserId).get();
        ZoneId defaultZoneId = ZoneId.systemDefault();

        if (!proUser.isPro()) {
            throw new RuntimeException("The provided pro user is not a professional user.");
        }

        Order order = new Order();
        order.setUser(user);
        order.setProUser(proUser);
        order.setOrderDate(Date.from(LocalDate.now().atStartOfDay(defaultZoneId).toInstant()));
        order.setAmount(BigDecimal.valueOf(60.0));
        order.setQuantity(2.0);
        order.setStatus(Order.OrderStatus.PENDING);
        Order savedOrder = orderRepository.save(order);

        return savedOrder;
    }

    public List<Order> getOrdersByUserId(Long userId) {
        return orderRepository.findByUserId(userId);
    }

    public List<Order> getOrdersByProUserId(Long proUserId) {
        return orderRepository.findByProUserId(proUserId);
    }

    public List<Order> getOrdersByUserEmail(String userEmail) {
        return orderRepository.findByUserEmail(userEmail);
    }

    public List<Order> getOrdersByProUserEmail(String proUserEmail) {
        return orderRepository.findByProUserEmail(proUserEmail);
    }
}
