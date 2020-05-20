import 'user.dart';

class G {
  static List<User> dummyUsers;
  static User loggedInUser;

  static void initDummyUsers() {
    User userA = User(id: 1000, name: "A", email: 'testa@gmail.com');
    User userB = User(id: 1000, name: "B", email: 'testb@gmail.com');
    dummyUsers = List();
    dummyUsers.add(userA);
    dummyUsers.add(userB);
  }

  static List<User> getUsersFor(User user) {
    List<User> filteredUser = dummyUsers
        .where(
          (u) => (!u.name.toLowerCase().contains(
                user.name.toLowerCase(),
              )),
        )
        .toList();
    return filteredUser;
  }
}
