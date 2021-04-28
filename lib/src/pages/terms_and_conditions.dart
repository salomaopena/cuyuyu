import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/shop_app_theme.dart';
import 'package:flutter/material.dart';

class TermsPage extends StatefulWidget {
  @override
  _TermsPageState createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  @override
  Widget build(BuildContext context) {
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
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Termos de uso',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(fontFamily: 'Raleway', fontSize: 20),
                            overflow: TextOverflow.ellipsis,
                          )),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        child: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(children: [
                            TextSpan(
                                text: '1.	Termos\n',
                                style: AppTheme.textTheme.headline6
                                    .copyWith(color: AppTheme.darkerText),
                                children: [
                                  TextSpan(
                                    text:
                                        '\nAo aceder ao Cuyuyu Entregas, concorda em cumprir estes termos de serviço, todas as leis e regulamentos aplicáveis e concorda que é responsável pelo cumprimento de todas as leis locais aplicáveis. Se você não concordar com algum desses termos, está proibido de usar ou aceder este aplicativo. Os materiais contidos neste aplicativo são protegidos pelas leis de direitos autorais e marcas comerciais aplicáveis.',
                                    style: AppTheme.caption.copyWith(
                                      color: AppTheme.darkerText,
                                      letterSpacing: 1.5,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ]),
                          ]),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        child: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(children: [
                            TextSpan(
                                text: '2.	Uso de licença\n',
                                style: AppTheme.textTheme.headline6
                                    .copyWith(color: AppTheme.darkerText),
                                children: [
                                  TextSpan(
                                      text:
                                          '\nÉ concedida permissão para baixar temporariamente uma cópia dos materiais (informações ou software) no Cuyuyu Entregas, apenas para visualização transitória pessoal e não comercial. Esta é a concessão de uma licença, não uma transferência de título e, sob esta licença, você não pode:',
                                      style: AppTheme.caption.copyWith(
                                        color: AppTheme.darkerText,
                                        letterSpacing: 1.5,
                                        fontStyle: FontStyle.normal,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              '\n\na)	Modificar ou copiar os materiais;             ',
                                          style: AppTheme.caption.copyWith(
                                            color: AppTheme.darkerText,
                                            letterSpacing: 1.5,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              '\n\nb)	Usar os materiais para qualquer finalidade comercial ou para exibição pública (comercial ou não comercial);             ',
                                          style: AppTheme.caption.copyWith(
                                            color: AppTheme.darkerText,
                                            letterSpacing: 1.5,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              '\n\nc)	Tentar descompilar ou fazer engenharia reversa de qualquer software contido no Cuyuyu Entregas;',
                                          style: AppTheme.caption.copyWith(
                                            color: AppTheme.darkerText,
                                            letterSpacing: 1.5,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              '\n\nd)	Remover quaisquer direitos autorais ou outras notações de propriedade dos materiais; ou',
                                          style: AppTheme.caption.copyWith(
                                            color: AppTheme.darkerText,
                                            letterSpacing: 1.5,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              '\n\n e)	Transferir os materiais para outra pessoa ou \'espelhe\' os materiais em qualquer outro servidor.',
                                          style: AppTheme.caption.copyWith(
                                            color: AppTheme.darkerText,
                                            letterSpacing: 1.5,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              '\n\nEsta licença será automaticamente rescindida se você violar alguma dessas restrições e poderá ser rescindida por Cuyuyu Entregas a qualquer momento. Ao encerrar a visualização desses materiais ou após o término desta licença, você deve apagar todos os materiais baixados em sua posse, seja em formato electrónico ou impresso.',
                                          style: AppTheme.caption.copyWith(
                                            color: AppTheme.darkerText,
                                            letterSpacing: 1.5,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        )
                                      ]),
                                ]),
                          ]),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        child: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(children: [
                            TextSpan(
                                text: '3. Isenção de responsabilidade\n',
                                style: AppTheme.textTheme.headline6
                                    .copyWith(color: AppTheme.darkerText),
                                children: [
                                  TextSpan(
                                    text:
                                        '\nOs materiais no aplicativo Cuyuyu Entregas são fornecidos \'como estão\'. Cuyuyu Entregas não oferece garantias, expressas ou implícitas, e, por este meio, isenta e nega todas as outras garantias, incluindo, sem limitação, garantias implícitas ou condições de comercialização, adequação a um fim específico ou não violação de propriedade intelectual ou outra violação de direitos. Além disso, o Cuyuyu Entregas não garante ou faz qualquer representação relativa à precisão, aos resultados prováveis ou à confiabilidade do uso dos materiais em seu aplicativo ou de outra forma relacionado a esses materiais ou em sites vinculados a este aplicativo.',
                                    style: AppTheme.caption.copyWith(
                                      color: AppTheme.darkerText,
                                      letterSpacing: 1.5,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ]),
                          ]),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        child: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(children: [
                            TextSpan(
                                text: '4.	Limitações\n',
                                style: AppTheme.textTheme.headline6
                                    .copyWith(color: AppTheme.darkerText),
                                children: [
                                  TextSpan(
                                    text:
                                        '\nEm nenhum caso o Cuyuyu Entregas ou seus fornecedores serão responsáveis por quaisquer danos (incluindo, sem limitação, danos por perda de dados ou lucro ou devido a interrupção dos negócios) decorrentes do uso ou da incapacidade de usar os materiais em Cuyuyu Entregas, mesmo que Cuyuyu Entregas ou um representante autorizado da Cuyuyu Entregas tenha sido notificado oralmente ou por escrito da possibilidade de tais danos. Como algumas jurisdições não permitem limitações em garantias implícitas, ou limitações de responsabilidade por danos consequentes ou incidentais, essas limitações podem não se aplicar a você.',
                                    style: AppTheme.caption.copyWith(
                                      color: AppTheme.darkerText,
                                      letterSpacing: 1.5,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ]),
                          ]),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        child: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(children: [
                            TextSpan(
                                text: '5.	Precisão dos materiais\n',
                                style: AppTheme.textTheme.headline6
                                    .copyWith(color: AppTheme.darkerText),
                                children: [
                                  TextSpan(
                                    text:
                                        '\nOs materiais exibidos no aplicativo da Cuyuyu Entregas podem incluir erros técnicos, tipográficos ou fotográficos. Cuyuyu Entregas não garante que qualquer material em seu aplicativo seja preciso, completo ou actual. Cuyuyu Entregas pode fazer alterações nos materiais contidos em seu aplicativo a qualquer momento, sem aviso prévio. No entanto, Cuyuyu Entregas não se compromete a actualizar os materiais.',
                                    style: AppTheme.caption.copyWith(
                                      color: AppTheme.darkerText,
                                      letterSpacing: 1.5,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ]),
                          ]),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        child: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(children: [
                            TextSpan(
                                text: '6.	Links\n',
                                style: AppTheme.textTheme.headline6
                                    .copyWith(color: AppTheme.darkerText),
                                children: [
                                  TextSpan(
                                    text:
                                        '\nO Cuyuyu Entregas não analisou todos os sites vinculados ao seu aplicativo e não é responsável pelo conteúdo de nenhum site vinculado. A inclusão de qualquer link não implica endosso por Cuyuyu Entregas. O uso de qualquer site vinculado é por conta e risco do usuário.',
                                    style: AppTheme.caption.copyWith(
                                      color: AppTheme.darkerText,
                                      letterSpacing: 1.5,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ]),
                          ]),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        child: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(children: [
                            TextSpan(
                                text: '7.	Modificações\n',
                                style: AppTheme.textTheme.headline6
                                    .copyWith(color: AppTheme.darkerText),
                                children: [
                                  TextSpan(
                                    text:
                                        '\nO Cuyuyu Entregas pode revisar estes termos de serviço do aplicativo a qualquer momento, sem aviso prévio. Ao usar este aplicativo, você concorda em ficar vinculado à versão actual desses termos de serviço.',
                                    style: AppTheme.caption.copyWith(
                                      color: AppTheme.darkerText,
                                      letterSpacing: 1.5,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ]),
                          ]),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        child: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(children: [
                            TextSpan(
                                text: '8.	Lei aplicável\n',
                                style: AppTheme.textTheme.headline6
                                    .copyWith(color: AppTheme.darkerText),
                                children: [
                                  TextSpan(
                                    text:
                                        '\nEstes termos e condições são regidos e interpretados de acordo com as leis do Cuyuyu Entregas e você se submete irrevogavelmente à jurisdição exclusiva dos tribunais naquela localidade.',
                                    style: AppTheme.caption.copyWith(
                                      color: AppTheme.darkerText,
                                      letterSpacing: 1.5,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ]),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              )
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
                  'Termos de uso',
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
}
