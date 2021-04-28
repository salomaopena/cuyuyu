
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/image_placeholder.dart';
import 'package:cuyuyu/src/utils/shop_app_theme.dart';
import 'package:flutter/material.dart';

class UpdateUserPage extends StatefulWidget {
  @override
  _UpdateUserPageState createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {
  bool _obscuredText = true;
  bool _confirmPassword = true;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: ShopAppTheme.buildLightTheme().backgroundColor,
      child: SafeArea(
        top: false,
        bottom: true,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: <Widget>[
              getAppBarUI(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        height: 140,
                        child: AspectRatio(
                          aspectRatio: 2,
                          child: Container(
                            child: _cuyuyuLogo(),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Form(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(
                                  left: 8.0, top: 4.0, bottom: 4.0, right: 8.0),
                              child: TextFormField(
                                textCapitalization: TextCapitalization.words,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                        fontFamily: 'Raleway', fontSize: 14),
                                cursorColor: colorScheme.onSurface,
                                autofocus: true,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  labelText: 'Nome',
                                  hintText: 'Nome',
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 8.0, top: 4.0, bottom: 4.0, right: 8.0),
                              child: TextFormField(
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                        fontFamily: 'Raleway', fontSize: 14),
                                cursorColor: colorScheme.onSurface,
                                autofocus: true,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  labelText: 'Telefone',
                                  hintText: 'Telefone',
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 8.0, top: 4.0, bottom: 4.0, right: 8.0),
                              child: TextFormField(
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                        fontFamily: 'Raleway', fontSize: 14),
                                cursorColor: colorScheme.onSurface,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  labelText: 'E-mail',
                                  hintText: 'E-mal',
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 8.0, top: 4.0, bottom: 4.0, right: 8.0),
                              child: TextFormField(
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                        fontFamily: 'Raleway', fontSize: 14),
                                cursorColor: colorScheme.onSurface,
                                obscureText: _confirmPassword,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  labelText: 'Password',
                                  hintText: 'Password',
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _confirmPassword = !_confirmPassword;
                                      });
                                    },
                                    child: Icon(_confirmPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 8.0, top: 4.0, bottom: 4.0, right: 8.0),
                              child: TextFormField(
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                        fontFamily: 'Raleway', fontSize: 14),
                                cursorColor: colorScheme.onSurface,
                                obscureText: _obscuredText,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  labelText: 'Confirmar password',
                                  hintText: 'Confirmar password',
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obscuredText = !_obscuredText;
                                      });
                                    },
                                    child: Icon(_obscuredText
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 8.0, top: 4.0, bottom: 4.0, right: 8.0),
                              child: TextFormField(
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                        fontFamily: 'Raleway', fontSize: 14),
                                cursorColor: colorScheme.onSurface,
                                autofocus: true,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  labelText: 'Endereço',
                                  hintText: 'Endereço',
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                                padding: EdgeInsets.only(
                                    left: 8.0,
                                    top: 4.0,
                                    bottom: 4.0,
                                    right: 8.0),
                                child: _bottonLogin()),
                            SizedBox(height: 10),
                            Divider(
                              indent: 100,
                            ),
                            SizedBox(height: 15),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 8.0, top: 4.0, bottom: 4.0, right: 8.0),
                              child: InkWell(
                                onTap: () {
                                  /* Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => HomePage()));*/
                                },
                                child: Text(
                                  'Já tenho conta',
                                  textAlign: TextAlign.end,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          color: AppTheme.cuyuyuOrange,
                                          fontSize: 14,
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: ShopAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.0),
              offset: const Offset(0, 0),
              blurRadius: 0.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back_ios),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  '',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    fontFamily: 'Raleway',
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
            )
          ],
        ),
      ),
    );
  }

  Widget _bottonLogin() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
      child: RaisedButton(
        color: AppTheme.cuyuyuOrange,
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Cadastrar',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle1.copyWith(
              fontFamily: 'Raleway',
              color: AppTheme.cuyuyuSurfaceWhite,
              fontWeight: FontWeight.w500),
        ),
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }

  Widget _cuyuyuLogo() {
    return FadeInImagePlaceholder(
      image: const AssetImage('images/logo_app.png'),
      height: 150,
      width: 150,
      placeholder: Container(
        width: 32,
        height: 32,
      ),
    );
  }
}
