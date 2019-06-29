class Item {
  final String name;
  final String icon;
  final String route;

  Item(this.name, this.icon, this.route);
}

final listItems = [
  Item("通知", "images/notification.png", "/"),
  Item("审批", "images/shenpi.png", "/"),
  Item("日历", "images/calender.png", "/"),
  Item("打卡", "images/attendance.png", "/"),
  Item("账户", "images/account.png", "/personalPage"),
  Item("团队", "images/team.png", "/teamPage"),
];
