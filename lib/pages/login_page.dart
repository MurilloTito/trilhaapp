import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController(text: 'email@gmail.com');
  TextEditingController passwordController = TextEditingController(text: '123');
  bool isObscureText = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40,),
                Row(
                  children: [
                    Expanded(child: Container()),
                    Expanded(
                      flex: 5,
                      child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfYBInJyGYkGdrcryoHDPAzkJt6QMcGJImhXzvhSQe&s'),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                const SizedBox(height: 20),
                const Text("Já tem cadastro?", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: Colors.grey)),
                const SizedBox(height: 10),
                const Text("Faça seu login e make the change_",
                style: TextStyle(fontSize: 16),),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: 30,
                  alignment: Alignment.center,
                  child: TextField(
                    controller: emailController,
                    onChanged: (value) {
                      print(value);
                    },
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(top: 0),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 182, 10, 168))),
                      hintText: "Email",
                      prefixIcon: Icon(Icons.person, color: Color.fromARGB(255, 182, 10, 168))),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: 30,
                  alignment: Alignment.center,
                  child: TextField(
                    controller: passwordController,
                    obscureText: isObscureText,
                    onChanged: (value) {
                      print(value);
                    },
                    decoration: InputDecoration(
                      enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 182, 10, 168))),
                      hintText: "Senha",
                      prefixIcon: const Icon(Icons.lock, color: Color.fromARGB(255, 182, 10, 168),),
                      suffixIcon: InkWell(onTap: () {
                        setState(() {
                          isObscureText = !isObscureText;
                        });
                      },
                      child: Icon(isObscureText ? Icons.visibility_off : Icons.visibility, 
                      color: const Color.fromARGB(255, 182, 10, 168))),
                    ),
                  )
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: 30,
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(onPressed: () {
                      if(emailController.text.trim() == 'email@gmail.com' && passwordController.text.trim() == '123') {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Tente novamente'))
                        );
                      }
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 182, 10, 168))
                    ), 
                    child: const Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),)),
                  ),
                ),
                Expanded(child: Container()),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: 30,
                  alignment: Alignment.center,
                  child: const Text('Esqueci minha senha', style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.w400)),
                ),
                const SizedBox(
                  height: 10,
                ),
                 Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: 30,
                  alignment: Alignment.center,
                  child: const Text('Criar conta', style: TextStyle(color: Colors.green, fontWeight: FontWeight.w400)),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
        ),
      ),
      ),
    );
  }
}