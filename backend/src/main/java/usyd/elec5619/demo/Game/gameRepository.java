package usyd.elec5619.demo.Game;

import org.springframework.data.jpa.repository.JpaRepository;
import usyd.elec5619.demo.Game.game;


public interface gameRepository extends JpaRepository<game, Long> {
}
