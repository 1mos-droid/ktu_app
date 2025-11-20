import 'package:flutter/material.dart';

void main() {
  runApp(const StudentApp());
}

class StudentApp extends StatelessWidget {
  const StudentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "KTU App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      initialRoute: "/login", // ✅ Start from homepage
      routes: {
        "/home": (context) => const HomePage(), // ✅ Added HomePage
        "/login": (context) => const LoginPage(),
        "/accountSelection": (context) => const AccountSelectionPage(),
        "/dashboard": (context) => const DashboardPage(),
      },
    );
  }
}

// ---------------- HOMEPAGE ----------------
// ---------------- NEW HOMEPAGE (Replica) ----------------
// 🟢 FIXED HomePage
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const _bg = Color(0xFFE8E9FF);
  static const _navy = Color(0xFF111F5C);
  static const _tileBg = Colors.white;
  static const _icon = Color(0xFF1C2A7A);
  static const _badge = Color(0xFFE53935);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF0D1B73),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Colors.black),
                ),
                SizedBox(height: 10),
                Text("XXXXXXXXXX XXXXX",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                Text("Student",
                    style: TextStyle(color: Colors.white70, fontSize: 14)),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard, color: Color(0xFF0D1B73)),
            title: const Text("Dashboard"),
            onTap: () => Navigator.pushReplacementNamed(context, "/dashboard"),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Color(0xFF0D1B73)),
            title: const Text("Home"),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.book, color: Color(0xFF0D1B73)),
            title: const Text("All Courses"),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout"),
            onTap: () => Navigator.pushReplacementNamed(context, "/login"),
          ),
        ],
      )),
      body: SafeArea(
        child: Stack(
          children: [
            // Top rounded header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Container(
                height: 96,
                decoration: BoxDecoration(
                  color: _navy,
                  borderRadius: BorderRadius.circular(28),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    // 🟢 FIXED: Drawer button
                    Builder(
                      builder: (context) => IconButton(
                        icon: const Icon(Icons.menu,
                            color: Colors.white, size: 28),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Home',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(child: FlutterLogo()),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 🟢 FIXED: Main card background
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 140, 16, 16),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    image: const DecorationImage(
                      image: AssetImage('assets/logo.jpg'), // FIXED
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _bg.withOpacity(0.55),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: GridView.count(
                      padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
                      crossAxisCount: 2,
                      mainAxisSpacing: 28,
                      crossAxisSpacing: 28,
                      childAspectRatio: .95,
                      // 🟢 FIXED: Allow scrolling
                      physics: const BouncingScrollPhysics(),
                      children: const [
                        _FeatureTile(
                          title: 'Assignments',
                          icon: Icons.menu_book_outlined,
                        ),
                        _FeatureTile(
                          title: 'Messages',
                          icon: Icons.markunread_outlined,
                          showBadge: true,
                        ),
                        _FeatureTile(
                          title: 'Timetable',
                          icon: Icons.calendar_month_outlined,
                        ),
                        _FeatureTile(
                          title: 'Grades',
                          icon: Icons.receipt_long_outlined,
                        ),
                        _FeatureTile(
                          title: 'Online Courses',
                          icon: Icons.computer_outlined,
                        ),
                        _FeatureTile(
                          title: 'Notifications',
                          icon: Icons.notifications_none_outlined,
                          showBadge: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool showBadge;
  final VoidCallback? onTap;

  const _FeatureTile({
    required this.title,
    required this.icon,
    this.showBadge = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 92,
                height: 92,
                decoration: BoxDecoration(
                  color: HomePage._tileBg,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.10),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Icon(icon, size: 42, color: HomePage._icon),
              ),
              if (showBadge)
                Positioned(
                  right: 4,
                  top: 4,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: HomePage._badge,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.5,
              fontWeight: FontWeight.w600,
              shadows: [
                Shadow(
                    blurRadius: 2, offset: Offset(0, 1), color: Colors.black26),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- LOGIN PAGE ----------------
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/download.jpeg", fit: BoxFit.cover),
          ),
          Container(color: const Color(0xCC001F54)),
          Column(
            children: [
              const SizedBox(height: 60),
              const Text(
                "KUMASI TECHNICAL UNIVERSITY",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                "Bachelor Of Arts\nCommunication Design",
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Image.asset("assets/images.png", height: 120),
              const SizedBox(height: 12),
              const Text(
                "Student Virtual Classroom",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(30),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: "Student School E-mail",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (errorMessage.isNotEmpty)
                      Text(errorMessage,
                          style: const TextStyle(color: Colors.red)),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          backgroundColor: const Color(0xFF001F54)),
                      onPressed: () {
                        if (emailController.text ==
                                "samuelmidozi@st.ktu.edu.gh" &&
                            passwordController.text == "password123") {
                          setState(() => errorMessage = "");
                          Navigator.pushReplacementNamed(context, "/dashboard");
                        } else {
                          setState(
                              () => errorMessage = "Invalid email or password");
                        }
                      },
                      child: const Text("Login",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 15),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text("Forgot password?",
                          style: TextStyle(color: Colors.blue)),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// ---------------- ACCOUNT SELECTION PAGE ----------------
class AccountSelectionPage extends StatelessWidget {
  const AccountSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF002366),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 60),
            const Text(
              "B.A Communication Design Mail",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Image.asset("assets/images.png", height: 120),
            const SizedBox(height: 20),
            const Text(
              "Let me know which account you are having trouble with?",
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/dashboard"),
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 60),
                  backgroundColor: Colors.cyan,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              child: const Text(
                "Work or school account\nCreated by your IT department",
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/dashboard"),
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 60),
                  backgroundColor: Colors.cyan,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              child: const Text(
                "Personal account\nCreated by you",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- DASHBOARD PAGE ----------------
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B73),

      // ✅ Side Navigation Drawer
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF0D1B73),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text("XXXXXXXXXX XXXXX",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  Text("Student",
                      style: TextStyle(color: Colors.white70, fontSize: 14)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard, color: Color(0xFF0D1B73)),
              title: const Text("Dashboard"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Color(0xFF0D1B73)),
              title: const Text("Home"),
              onTap: () => Navigator.pushReplacementNamed(context, "/home"),
            ),
            ListTile(
              leading: const Icon(Icons.book, color: Color(0xFF0D1B73)),
              title: const Text("All Courses"),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout"),
              onTap: () => Navigator.pushReplacementNamed(context, "/login"),
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 40),
          child: Column(
            children: [
              // Top bar
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(
                      builder: (context) => IconButton(
                        icon: const Icon(Icons.menu,
                            color: Colors.white, size: 28),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                    ),
                    const Text("Dashboard",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    Image.asset("assets/logo.jpg", height: 32),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Profile
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: const Icon(Icons.person, size: 60, color: Colors.black),
              ),
              const SizedBox(height: 12),
              const Text("XXXXXXXXXX XXXXX",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              const Text("Student", style: TextStyle(color: Colors.white)),
              const SizedBox(height: 24),

              // White Card
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          DashboardItem(
                              label: "Timeline", icon: Icons.access_time),
                          DashboardItem(
                              label: "Calendar", icon: Icons.calendar_today),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          DashboardItem(label: "New Events", icon: Icons.event),
                          DashboardItem(label: "All Courses", icon: Icons.book),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const DashboardItem(
                          label: "Contact site support",
                          icon: Icons.support_agent),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Logout
              ElevatedButton.icon(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, "/login"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D1B73),
                  minimumSize: const Size(250, 55),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                label: const Text("Logout",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- DASHBOARD ITEM ----------------
class DashboardItem extends StatelessWidget {
  final String label;
  final IconData icon;

  const DashboardItem({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Column(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: const Color(0xFFF2F2F2),
            child: SizedBox(
              height: 70,
              width: 70,
              child: Icon(icon, size: 36, color: Color(0xFF0D1B73)),
            ),
          ),
          const SizedBox(height: 8),
          Text(label,
              style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF0D1B73),
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
