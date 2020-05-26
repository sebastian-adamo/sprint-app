package sa775.Sprint.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@RequestMapping("/team")
public class TeamController {

    @GetMapping("/create")
    public String create(@RequestParam("name") String name, @RequestParam("description") String description) {
        
    }
}
