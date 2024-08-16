//package usyd.elec5619.demo.ORDER;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.security.core.annotation.AuthenticationPrincipal;
//import org.springframework.web.bind.annotation.*;
//import usyd.elec5619.demo.USER.UserService;
//import usyd.elec5619.demo.USER.User;
//import usyd.elec5619.demo.USER.UserDTO;
//import usyd.elec5619.demo.USER.UserService;
//
//import java.util.ArrayList;
//import java.util.List;
//import java.util.Optional;
//import java.util.stream.Collectors;
//import usyd.elec5619.demo.Game.game;  // Assuming your Game class is in this package
//import usyd.elec5619.demo.Game.gameService;
//
//@RestController
//@RequestMapping("/pwf")
//public class OrderController {
//
//    @Autowired
//    private UserService userService;
//
//    @Autowired
//    private OrderService orderService;
//    @Autowired
//    private gameService gameService;
//
//    // Temporary storage for cart items
//    private List<OrderDTO> cart = new ArrayList<>();
//    @GetMapping("/games")
//    public ResponseEntity<List<game>> listAllGames() {
//        return new ResponseEntity<>(gameService.finAll(), HttpStatus.OK);
//    }
//
//    // List all proUsers for a specific game
//    @GetMapping("/games/{gameId}/users")
//    public ResponseEntity<List<User>> listProUsersForGame(@PathVariable Long gameId) {
//        Optional<game> optionalGame = gameService.findById(gameId);
//
//        if (!optionalGame.isPresent()) {
//            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
//        }
//
//        game game = optionalGame.get();
//        List<User> usersForGame = game.getListOfUserId();
//
//        List<User> proUsers = new ArrayList<>();
//        for (User user : usersForGame) {
//            if (user.isPro()) {
//                proUsers.add(user);
//            }
//        }
//
//        return new ResponseEntity<>(proUsers, HttpStatus.OK);
//    }
//
//
//    @GetMapping("/market")
//    public ResponseEntity<List<User>> listMarketItems() {
//        List<User> allUsers = userService.findAll();
//
//        List<User> proUsers = new ArrayList<>();
//        for (User user : allUsers) {
//            if (user.isPro()) {
//                proUsers.add(user);
//            }
//        }
//        return new ResponseEntity<>(proUsers, HttpStatus.OK);
//    }
//
//    @PostMapping("/cart/add/{userId}")
//    public ResponseEntity<OrderDTO> addToCart(@PathVariable Long userId) {
//        List<User> allUsers = userService.findAll();
//        Optional<User> optionalProUser = userService.findById(userId);
//
//        if (!optionalProUser.isPresent()) {
//            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
//        }
//
//        User proUser = optionalProUser.get();
//
//        if (!proUser.isPro()) {
//            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
//        }
//
//        OrderDTO orderDto = new OrderDTO();
//        orderDto.setProUser(proUser);
//        orderDto.setQuantity(0.5);
//
//
//        cart.add(orderDto);
//        return new ResponseEntity<>(orderDto, HttpStatus.CREATED);
//    }
//
//    @GetMapping("/cart")
//    public ResponseEntity<List<OrderDTO>> viewCart() {
//        return new ResponseEntity<>(cart, HttpStatus.OK);
//    }
//
//    @PutMapping("/cart/{orderId}/increment")
//    public ResponseEntity<OrderDTO> incrementOrderQuantity(@PathVariable Long orderId) {
//        OrderDTO order = findOrderInCart(orderId);
//        if (order != null) {
//            order.setQuantity(order.getQuantity() + 0.5);
//            return new ResponseEntity<>(order, HttpStatus.OK);
//        }
//        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
//    }
//
//    @PutMapping("/cart/{orderId}/decrement")
//    public ResponseEntity<OrderDTO> decrementOrderQuantity(@PathVariable Long orderId) {
//        OrderDTO order = findOrderInCart(orderId);
//        if (order != null && order.getQuantity() > 0.5) {
//            order.setQuantity(order.getQuantity() - 0.5);
//            return new ResponseEntity<>(order, HttpStatus.OK);
//        }
//        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
//    }
//
//    @DeleteMapping("/cart/{orderId}")
//    public ResponseEntity<Void> removeFromCart(@PathVariable Long orderId) {
//        cart.removeIf(order -> order.getOrderId().equals(orderId));
//        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
//    }
//
//    @PostMapping("/cart/checkout")
//    public ResponseEntity<Void> checkout() {
//        for (OrderDTO orderDto : cart) {
//            orderService.createOrder(orderDto);
//        }
//        cart.clear();
//        return new ResponseEntity<>(HttpStatus.CREATED);
//    }
//
//    private OrderDTO findOrderInCart(Long orderId) {
//        return cart.stream()
//                .filter(order -> order.getOrderId().equals(orderId))
//                .findFirst()
//                .orElse(null);
//    }
//}

package usyd.elec5619.demo.ORDER;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import usyd.elec5619.demo.Game.game;
import usyd.elec5619.demo.Game.gameService;
import usyd.elec5619.demo.USER.UserService;
import usyd.elec5619.demo.USER.User;
import usyd.elec5619.demo.USER.UserDTO;
import usyd.elec5619.demo.USER.UserService;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/pwf")
public class OrderController {

    @Autowired
    private UserService userService;

    @Autowired
    private OrderService orderService;

    @Autowired
    private gameService gameService;

    // Temporary storage for cart items
    private List<OrderDTO> cart = new ArrayList<>();


    @GetMapping("/notification")
    public ResponseEntity<List<OrderDTO>> getPendingOrders() {
        List<OrderDTO> pendingOrders = orderService.findOrdersByStatus(Order.OrderStatus.PENDING);
        return new ResponseEntity<>(pendingOrders, HttpStatus.OK);
    }

    @PostMapping("/order/accept/{orderId}")
    public ResponseEntity<Void> acceptOrder(@PathVariable Long orderId) {
        Optional<OrderDTO> optionalOrder = orderService.findById(orderId);

        if (!optionalOrder.isPresent()) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }

        OrderDTO order = optionalOrder.get();
        order.setStatus(Order.OrderStatus.ACCEPTED);
        orderService.save(order);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PostMapping("/order/decline/{orderId}")
    public ResponseEntity<Void> declineOrder(@PathVariable Long orderId) {
        Optional<OrderDTO> optionalOrder = orderService.findById(orderId);

        if (!optionalOrder.isPresent()) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }

        OrderDTO order = optionalOrder.get();
        orderService.delete(order);  // This will delete the order from the database
        return new ResponseEntity<>(HttpStatus.OK);
    }

//    @GetMapping("/games")
//    public ResponseEntity<List<game>> listAllGames() {
//        return new ResponseEntity<>(gameService.finAll(), HttpStatus.OK);
//    }
//
//    // List all proUsers for a specific game
//    @GetMapping("/games/{gameId}/users")
//    public ResponseEntity<List<User>> listProUsersForGame(@PathVariable Long gameId) {
//        Optional<game> optionalGame = gameService.findById(gameId);
//
//        if (!optionalGame.isPresent()) {
//            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
//        }
//
//        game game = optionalGame.get();
//        List<User> usersForGame = game.getListOfUserId();
//
//        List<User> proUsers = new ArrayList<>();
//        for (User user : usersForGame) {
//            if (user.isPro()) {
//                proUsers.add(user);
//            }
//        }
//
//        return new ResponseEntity<>(proUsers, HttpStatus.OK);
//    }



    @GetMapping("/market")
    public ResponseEntity<List<User>> listMarketItems() {
        List<User> allUsers = userService.findAll();

        List<User> proUsers = new ArrayList<>();
        for (User user : allUsers) {
            if (user.isPro()) {
                proUsers.add(user);
            }
        }
        return new ResponseEntity<>(proUsers, HttpStatus.OK);
    }

    @PostMapping("/cart/add/{userEmail}/{proUserId}")
    public ResponseEntity<Order> addToCart(@PathVariable String userEmail, @PathVariable int proUserId) {
        Optional<User> optionalUser = userService.findByEmailTwo(userEmail);
        Optional<User> optionalProUser = userService.findById(proUserId);

        if (!optionalUser.isPresent() || !optionalProUser.isPresent()) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }

        if (optionalUser.get().getEmail().equals(optionalProUser.get().getEmail())) {
            return new ResponseEntity<>(HttpStatus.FORBIDDEN);
        }

        User user = optionalUser.get();
        User proUser = optionalProUser.get();

        if (!proUser.isPro()) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }

        Order order = orderService.addToCart(userEmail, proUserId);
        return new ResponseEntity<>(order, HttpStatus.CREATED);
    }

    @GetMapping("/cart")
    public ResponseEntity<List<OrderDTO>> viewCart() {
        return new ResponseEntity<>(cart, HttpStatus.OK);
    }

    @PutMapping("/cart/{orderId}/increment")
    public ResponseEntity<OrderDTO> incrementOrderQuantity(@PathVariable Long orderId) {
        OrderDTO order = findOrderInCart(orderId);
        if (order != null) {
            order.setQuantity(order.getQuantity() + 0.5);
            return new ResponseEntity<>(order, HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    @PutMapping("/cart/{orderId}/decrement")
    public ResponseEntity<OrderDTO> decrementOrderQuantity(@PathVariable Long orderId) {
        OrderDTO order = findOrderInCart(orderId);
        if (order != null && order.getQuantity() > 0.5) {
            order.setQuantity(order.getQuantity() - 0.5);
            return new ResponseEntity<>(order, HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    @DeleteMapping("/cart/{orderId}")
    public ResponseEntity<Void> removeFromCart(@PathVariable Long orderId) {
        cart.removeIf(order -> order.getOrderId().equals(orderId));
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @PostMapping("/cart/checkout")
    public ResponseEntity<Void> checkout() {
        for (OrderDTO orderDto : cart) {
            orderService.createOrder(orderDto);  // This saves the order permanently
        }
        cart.clear();
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    private OrderDTO findOrderInCart(Long orderId) {
        return cart.stream()
                .filter(order -> order.getOrderId().equals(orderId))
                .findFirst()
                .orElse(null);
    }

    @GetMapping("/cartorder/{userEmail}")
    public ResponseEntity<List<Order>> getOrdersByUserEmail(@PathVariable String userEmail) {
        List<Order> orders = orderService.getOrdersByUserEmail(userEmail);
        if (orders.isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        }
        return new ResponseEntity<>(orders, HttpStatus.OK);
    }

    @GetMapping("/procartorder/{userEmail}")
    public ResponseEntity<List<Order>> getOrdersByProUserEmail(@PathVariable String userEmail) {
        List<Order> orders = orderService.getOrdersByProUserEmail(userEmail);
        if (orders.isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        }
        return new ResponseEntity<>(orders, HttpStatus.OK);
}

}