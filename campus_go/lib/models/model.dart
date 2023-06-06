
class Question {
  String question;
  String content;
  int votes;
  int repliesCount;
  int views;
  String created_at;
  Author author;
  List<Reply> replies;

  Question(
      {required this.question,
      required this.content,
      required this.votes,
      required this.repliesCount,
      required this.views,
      required this.created_at,
      required this.author,
      required this.replies});
}

List<Question> questions = [
  Question(
      author: mike,
      question: 'C ## In A Nutshell',
      content:
          "Lorem  i've been using c## for a whole decade now, if you guys know how to break the boring feeling of letting to tell everyne of what happed in the day",
      created_at: "1h ago",
      views: 120,
      votes: 100,
      repliesCount: 80,
      replies: replies),
  Question(
      author: john,
      question: 'List<Dynamic> is not a subtype of Lits<Container>',
      content:
          "Lorem  i've been using c## for a whole decade now, if you guys know how to break the boring feeling of letting to tell everyne of what happed in the day",
      created_at: "2h ago",
      views: 20,
      votes: 10,
      repliesCount: 10,
      replies: replies),
  Question(
      author: sam,
      question: 'React a basic error 404 is not typed',
      content:
          "Lorem  i've been using c## for a whole decade now, if you guys know how to break the boring feeling of letting to tell everyne of what happed in the day",
      created_at: "4h ago",
      views: 220,
      votes: 107,
      repliesCount: 67,
      replies: replies),
  Question(
      author: mark,
      question: 'Basic understanding of what is not good',
      content:
          "Lorem  i've been using c## for a whole decade now, if you guys know how to break the boring feeling of letting to tell everyne of what happed in the day",
      created_at: "10h ago",
      views: 221,
      votes: 109,
      repliesCount: 67,
      replies: replies),
  Question(
      author: justin,
      question: 'Luther is not author in here',
      content:
          "Lorem  i've been using c## for a whole decade now, if you guys know how to break the boring feeling of letting to tell everyne of what happed in the day",
      created_at: "24h ago",
      views: 325,
      votes: 545,
      repliesCount: 120,
      replies: replies),
];

//-----

class Author {
  String name;
  String imageUrl;

  Author({required this.name, required this.imageUrl});
}

final Author mark =
    Author(name: 'Mark Lewis', imageUrl: 'assets/images/author1.jpg');

final Author john =
    Author(name: 'John Sabestiam', imageUrl: 'assets/images/author2.jpg');

final Author mike =
    Author(name: 'Mike Ruther', imageUrl: 'assets/images/author3.jpg');

final Author adam =
    Author(name: 'Adam Zampal', imageUrl: 'assets/images/author4.jpg');
final Author justin =
    Author(name: 'Justin Neither', imageUrl: 'assets/images/author5.jpg');
final Author sam =
    Author(name: 'Samuel Tarly', imageUrl: 'assets/images/author6.jpg');
final Author luther =
    Author(name: 'Luther', imageUrl: 'assets/images/author7.jpg');

final List<Author> authors = [luther, sam, justin, adam, mike, john, mark];

//------

class Reply {
  Author author;
  String content;
  int likes;

  Reply({required this.author, required this.content, required this.likes});
}

List<Reply> replies = [
  Reply(
      author: mike,
      content:
          'LMOA try to learn php using udemy or youtube courses if your good enough elrrn from docs',
      likes: 10),
  Reply(
      author: john,
      content: 'Officiis iusto dolorum delectus totam. Replioe',
      likes: 120),
  Reply(
      author: mark,
      content:
          'distinctio nostrum nobis, nisi vel quasi amet laborum nam saepe ullam fuga. ellendus alias rem facere obcaecati.',
      likes: 67),
  Reply(
      author: sam,
      content:
          'Asperiores quisquam perspiciatis iure commodi quidem vitae modi, nemo optio eos cum labore ',
      likes: 34),
  Reply(
      author: adam,
      content:
          'nemo totam voluptatum qui error obcaecati assumenda temporibus blanditiis unde, maiores velit tempora neque, porro autem ab eveniet. ',
      likes: 89),
  Reply(
      author: luther,
      content:
          'amet quo. Accusantium nam reiciendis quisquam voluptate impedit mollitia debitis facilis, ',
      likes: 12),
  Reply(
      author: justin,
      content:
          'fugiat autem a neque esse error quia itaque molestiae praesentium, totam aspernatur earum dicta, ',
      likes: 27),
];
