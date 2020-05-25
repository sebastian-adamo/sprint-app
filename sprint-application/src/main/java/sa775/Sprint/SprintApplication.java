package sa775.Sprint;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import sa775.Sprint.Domain.*;
import sa775.Sprint.Repository.*;
import sa775.Sprint.Service.NotificationService;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@SpringBootApplication
// public class SprintApplication extends SpringBootServletInitializer implements CommandLineRunner {
public class SprintApplication implements CommandLineRunner {

	@Autowired
	private BoardRepository boardRepository;
	@Autowired
	private UserRepository userRepository;
	@Autowired
	private BoardRoleRepository boardRoleRepository;
	@Autowired
	private TeamRepository teamRepository;

	public static void main(String[] args) {
		SpringApplication.run(SprintApplication.class, args);
	}


	// @Override
	// protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
	// 	return builder.sources(SprintApplication.class);
	// }


	@Override
	public void run(String... args) throws Exception{

		// Creating Users
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		User user = new User("admin", "admin@sprint.com", encoder.encode("admin"));
		User jake = new User("ninja111999", "ninja111999@sprint.com", encoder.encode("jake"));
		User seb = new User("VergeofEden", "VergeofEden@sprint.com", encoder.encode("seb"));
		User joe = new User("joe147258", "joe147258@sprint.com", encoder.encode("joe"));

		// Creating Board
		Board b = new Board("Dissertation Software");
		b.setDescription("Kanban board assisting in Dissertation project.");
		b.setDefinitionOfDone("Code Reviewed, Functionality Confirmed, Usability Tests Passed");

		// Creating Tasks and Adding them to the board
		Task tb = new Task("Password Recovery", "Functioning password recovery system via e-mail", false, false, 0);
		Comment tbc = new Comment("admin", "Testing the task commments feature");
		Comment tbc1 = new Comment("admin", "Testing the task commments feature again");
		tb.getComments().add(tbc);
		tb.getComments().add(tbc1);
		tb.setPosition(0);
		b.addBacklog(tb);

		Task tb1 = new Task("Calendar Feature", "Calendar feature with task due dates linked in to Outlook Calendar", false, false, 0);
		tb1.setPosition(1);
		b.addBacklog(tb1);

		Task tt = new Task("Custom Poll Options", "Add some custom poll options",false, false, 0);
		tt.setPosition(0);
		b.addTodo(tt);

		Task tt1 = new Task("Group Projects", "Move project collaboration to group section",false, false, 0);
		tt1.setPosition(1);
		b.addTodo(tt1);

		Task tt2 = new Task("Group Chat", "Migrate activity feature to group chat",false, false, 0);
		tt2.setPosition(2);
		b.addTodo(tt2);

		Task tt3 = new Task("Project Documents", "Add project specific documents upload feature",false, false, 0);
		tt3.setPosition(3);
		b.addTodo(tt3);

		Task ti = new Task("Fix Poll Delete Bug", "Fix delete bug in Poll's feature",false, false, 0);
		ti.setPosition(0);
		b.addInprogress(ti);

		Task ti1 = new Task("Work on Theme", "Migrate text to intuitive icons",true, false, 50);
		ti1.setPosition(1);
		b.addInprogress(ti1);

		Task tc = new Task("Written Dissertation", "Write dissertation",true, true, 100);
		tc.setPosition(0);
		b.addComplete(tc);

		Task tc1 = new Task("Registration/Login", "Registration and login restriction",true, true, 100);
		tc1.setPosition(1);
		b.addComplete(tc1);

		Task tc2 = new Task("Poll Feature", "",true, true, 100);
		tc2.setPosition(2);
		b.addComplete(tc2);

		Task tc3 = new Task("Proof Read Dissertation", "Proof read written dissertation",true, true, 100);
		tc3.setPosition(3);
		b.addComplete(tc3);

		Task tc4 = new Task("Activity Feature", "Add activity to tasks and boards",true, true, 100);
		tc4.setPosition(4);
		b.addComplete(tc4);

		// Adding a comment to the board
		Comment p = new Comment();
		p.setUsername(user.getUsername());
		p.setDescription("Testing Seen Comments and im testing the length of the box");
		b.addComment(p);

		Comment p1 = new Comment();
		p1.setUsername(user.getUsername());
		p1.setDescription("Testing Unseen Comments");

		// Saving Users and Boards
		userRepository.save(seb);
		userRepository.save(joe);
		userRepository.save(jake);
		userRepository.save(user);

		boardRepository.save(b);

		b.setOwner(user);
		boardRepository.save(b);

		// Adding users to board using roles
		BoardRole ba = new BoardRole(user, b, "Product Owner");
		b.getBoardRoles().add(ba);
		user.getBoardRoles().add(ba);
		boardRoleRepository.save(ba);

		BoardRole ba1 = new BoardRole(jake, b, "Scrum Master");
		b.getBoardRoles().add(ba1);
		jake.getBoardRoles().add(ba1);
		boardRoleRepository.save(ba1);

		BoardRole ba2 = new BoardRole(seb, b, "Developer");
		b.getBoardRoles().add(ba2);
		seb.getBoardRoles().add(ba2);
		boardRoleRepository.save(ba2);

		Team team = new Team("Sprint Team", "Team used for developing the Sprint application.");
		teamRepository.save(team);
		team.getUsers().add(user);
		user.getTeams().add(team);
		teamRepository.save(team);

		System.out.println("Main application has run successfully");
	}
}
