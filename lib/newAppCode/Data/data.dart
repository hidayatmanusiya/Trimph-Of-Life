import 'package:flutter/cupertino.dart';
import 'package:triumph_life_ui/newappcode/Models/friends_model.dart';
import 'package:triumph_life_ui/newappcode/Models/models.dart';
import 'package:triumph_life_ui/newappcode/Models/request_model.dart';
import 'package:triumph_life_ui/newappcode/Models/suggestion_model.dart';

final User currentUser = User(
  name: 'Mark Ruffalo',
  imageUrl: 'https://images.unsplash.com/photo-1578133671540-edad0b3d689e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1351&q=80',
  gender: 'Male', proffesion: 'Doctor', address: 'Live in Colarado,USA', month: '02', date: '02', year: '1991',
);

final List<User> onlineUsers = [
  User(
    name: 'David Brooks',
    gender: 'Male', proffesion: 'Doctor', address: 'Live in Colarado,USA', month: '02', date: '02', year: '1991',
    imageUrl:
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
  User(
    gender: 'Male', proffesion: 'Doctor', address: 'Live in Colarado,USA', month: '02', date: '02', year: '1991',
    name: 'Jane Doe',
    imageUrl:
    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
  User(
    gender: 'Male', proffesion: 'Doctor', address: 'Live in Colarado,USA', month: '02', date: '02', year: '1991',
    name: 'Matthew Hinkle',
    imageUrl:
    'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1331&q=80',
  ),
  User(
    gender: 'Male', proffesion: 'Doctor', address: 'Live in Colarado,USA', month: '02', date: '02', year: '1991',
    name: 'Amy Smith',
    imageUrl:
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80',
  ),
  User(
    gender: 'Male', proffesion: 'Doctor', address: 'Live in Colarado,USA', month: '02', date: '02', year: '1991',
    name: 'Ed Morris',
    imageUrl:
    'https://images.unsplash.com/photo-1521119989659-a83eee488004?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=664&q=80',
  ),
  User(
    gender: 'Male', proffesion: 'Doctor', address: 'Live in Colarado,USA', month: '02', date: '02', year: '1991',
    name: 'Carolyn Duncan',
    imageUrl:
    'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
  User(
    gender: 'Male', proffesion: 'Doctor', address: 'Live in Colarado,USA', month: '02', date: '02', year: '1991',
    name: 'Paul Pinnock',
    imageUrl:
    'https://images.unsplash.com/photo-1519631128182-433895475ffe?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
  ),
  User(
      gender: 'Male', proffesion: 'Doctor', address: 'Live in Colarado,USA', month: '02', date: '02', year: '1991',
      name: 'Elizabeth Wong',
      imageUrl:
      'https://images.unsplash.com/photo-1515077678510-ce3bdf418862?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjF9&auto=format&fit=crop&w=675&q=80'),
  User(
    gender: 'Male', proffesion: 'Doctor', address: 'Live in Colarado,USA', month: '02', date: '02', year: '1991',
    name: 'James Lathrop',
    imageUrl:
    'https://images.unsplash.com/photo-1528892952291-009c663ce843?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=592&q=80',
  ),
  User(
    gender: 'Male', proffesion: 'Doctor', address: 'Live in Colarado,USA', month: '02', date: '02', year: '1991',
    name: 'Jessie Samson',
    imageUrl:
    'https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
  User(
    gender: 'Male', proffesion: 'Doctor', address: 'Live in Colarado,USA', month: '02', date: '02', year: '1991',
    name: 'David Brooks',
    imageUrl:
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
  User(
    gender: 'Male', proffesion: 'Doctor', address: 'Live in Colarado,USA', month: '02', date: '02', year: '1991',
    name: 'Jane Doe',
    imageUrl:
    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
  User(
    gender: 'Male', proffesion: 'Doctor', address: 'Live in Colarado,USA', month: '02', date: '02', year: '1991',
    name: 'Matthew Hinkle',
    imageUrl:
    'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1331&q=80',
  ),
  User(
    gender: 'Male', proffesion: 'Doctor', address: 'Live in Colarado,USA', month: '02', date: '02', year: '1991',
    name: 'Amy Smith',
    imageUrl:
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80',
  ),
  User(
    gender: 'Male', proffesion: 'Doctor', address: 'Live in Colarado,USA', month: '02', date: '02', year: '1991',
    name: 'Ed Morris',
    imageUrl:
    'https://images.unsplash.com/photo-1521119989659-a83eee488004?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=664&q=80',
  ),
  User(
    gender: 'Male', proffesion: 'Doctor', address: 'Live in Colarado,USA', month: '02', date: '02', year: '1991',
    name: 'Carolyn Duncan',
    imageUrl:
    'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
  User(
    gender: 'Male', proffesion: 'Doctor', address: 'Live in Colarado,USA', month: '02', date: '02', year: '1991',
    name: 'Paul Pinnock',
    imageUrl:
    'https://images.unsplash.com/photo-1519631128182-433895475ffe?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
  ),
  User(
      gender: 'Male', proffesion: 'Doctor', address: 'Live in Colarado,USA', month: '02', date: '02', year: '1991',
      name: 'Elizabeth Wong',
      imageUrl:
      'https://images.unsplash.com/photo-1515077678510-ce3bdf418862?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjF9&auto=format&fit=crop&w=675&q=80'),
  User(
    gender: 'Male', proffesion: 'Doctor', address: 'Live in Colarado,USA', month: '02', date: '02', year: '1991',
    name: 'James Lathrop',
    imageUrl:
    'https://images.unsplash.com/photo-1528892952291-009c663ce843?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=592&q=80',
  ),
  User(
    gender: 'Male', proffesion: 'Doctor', address: 'Live in Colarado,USA', month: '02', date: '02', year: '1991',
    name: 'Jessie Samson',
    imageUrl:
    'https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
];

final List<Notifications> notifications=[
  Notifications(
    user:onlineUsers[1],
    time: '15',
    time_type: 'sec',
  ),
  Notifications(
    user:onlineUsers[2],
    time: '20',
    time_type: 'min',
  ),
  Notifications(
    user:currentUser,
    time: '15',
    time_type: 'sec',
  ),
  Notifications(
    user:onlineUsers[3],
    time: '15',
    time_type: 'sec',
  ),
  Notifications(
    user:onlineUsers[1],
    time: '15',
    time_type: 'sec',
  ),
  Notifications(
    user:onlineUsers[2],
    time: '20',
    time_type: 'min',
  ),
  Notifications(
    user:currentUser,
    time: '15',
    time_type: 'sec',
  ),
  Notifications(
    user:onlineUsers[3],
    time: '15',
    time_type: 'sec',
  ),
];

final List<Request> request=[
  Request(user: onlineUsers[0], mutual: 2),
  Request(user: onlineUsers[1], mutual: 3),
  Request(user: onlineUsers[2], mutual: 4),
  Request(user: onlineUsers[3], mutual: 5),
  Request(user: onlineUsers[4], mutual: 6),
  Request(user: onlineUsers[5], mutual: 7),
  Request(user: onlineUsers[6], mutual: 8),
  Request(user: onlineUsers[7], mutual: 9),
  Request(user: onlineUsers[8], mutual: 10),
  Request(user: onlineUsers[9], mutual: 11),
];

final List<Suggestions> suggestions=[
  Suggestions(user: onlineUsers[0], mutual: 2),
  Suggestions(user: onlineUsers[1], mutual: 3),
  Suggestions(user: onlineUsers[2], mutual: 4),
  Suggestions(user: onlineUsers[3], mutual: 5),
  Suggestions(user: onlineUsers[4], mutual: 6),
  Suggestions(user: onlineUsers[5], mutual: 7),
  Suggestions(user: onlineUsers[6], mutual: 8),
  Suggestions(user: onlineUsers[7], mutual: 9),
  Suggestions(user: onlineUsers[8], mutual: 10),
  Suggestions(user: onlineUsers[9], mutual: 11),
];

final List<Friends> friends=[
  Friends(user: onlineUsers[0],time_type: 'hour', time: '1'),
  Friends(user: onlineUsers[1],time_type: 'sec', time: '20'),
];

final List<Messages> messages=[
  Messages(user: onlineUsers[0], upper_mesg: 'Whats your view on the new'),
  Messages(user: onlineUsers[1], upper_mesg: 'Tommorow sounds good,I am'),
  Messages(user: onlineUsers[2], upper_mesg: 'Whats your view on the new'),
  Messages(user: onlineUsers[3], upper_mesg: 'Tommorow sounds good,I am'),
  Messages(user: onlineUsers[4], upper_mesg: 'Whats your view on the new'),
  Messages(user: onlineUsers[5], upper_mesg: 'Whats your view on the new'),
  Messages(user: onlineUsers[6], upper_mesg: 'Tommorow sounds good,I am'),
  Messages(user: onlineUsers[7], upper_mesg: 'Whats your view on the new'),
  Messages(user: onlineUsers[8], upper_mesg: 'Whats your view on the new'),
];

final List<Post> posts = [
  Post(
    user: currentUser,
    caption: 'Check out',
    timeAgo: '58m',
    imageUrl: 'https://images.unsplash.com/photo-1525253086316-d0c936c814f8',
    likes: 1202,
    comments: 184,
    shares: 96,
  ),
  Post(
    user: onlineUsers[5],
    caption: "That awkward moment when you're wearing Nike's and you can't do it",
  timeAgo: '3hr',
    imageUrl: 'null',
    likes: 683,
    comments: 79,
    shares: 18,
  ),
  Post(
    user: onlineUsers[4],
    caption: 'You become what you believe.',
    timeAgo: '8hr',
    imageUrl:
    'https://images.unsplash.com/photo-1575535468632-345892291673?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    likes: 894,
    comments: 201,
    shares: 27,
  ),
  Post(
    user: onlineUsers[3],
    caption: 'Embrace what makes you unique, even if it makes others uncomfortable.',
    timeAgo: '15hr',
    imageUrl:
    'https://images.unsplash.com/photo-1573331519317-30b24326bb9a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
    likes: 722,
    comments: 183,
    shares: 42,
  ),
  Post(
    user: onlineUsers[0],
    caption: 'More placeholder text for the soul: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    timeAgo: '1d',
    imageUrl: 'null',
    likes: 482,
    comments: 37,
    shares: 9,
  ),
  Post(
    user: onlineUsers[9],
    caption: "Everything you've ever wanted is on the other side of fear. -George Addair",
    timeAgo: '1d',
    imageUrl:
    'https://images.unsplash.com/reserve/OlxPGKgRUaX0E1hg3b3X_Dumbo.JPG?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    likes: 1523,
    shares: 129,
    comments: 301,
  )
];