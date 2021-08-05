//@dart=2.9
import 'package:cuyuyu/src/components/bottom_nav_bar.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/enums.dart';
import 'package:flutter/material.dart';

class TermsPage extends StatefulWidget {
  @override
  _TermsPageState createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Termos de utilização", style: AppTheme.title),
        elevation: 0,
        iconTheme: IconThemeData.fallback(),
        backgroundColor: Colors.transparent,
        foregroundColor: AppTheme.nearlyBlack,
      ),
      backgroundColor: AppTheme.nearlyWhite,
      body: Column(
        children: <Widget>[
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
                        style: AppTheme.display6.copyWith(fontSize: 20),
                        overflow: TextOverflow.ellipsis,
                      )),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(children: [
                        TextSpan(
                            text: '1.	Termos\n',
                            style: AppTheme.display6,
                            children: [
                              TextSpan(
                                text:
                                    '\nAo aceder ao Cuyuyu Entregas, concorda em cumprir estes termos de serviço, todas as leis e regulamentos aplicáveis e concorda que é responsável pelo cumprimento de todas as leis locais aplicáveis. Se você não concordar com algum desses termos, está proibido de usar ou aceder este aplicativo. Os materiais contidos neste aplicativo são protegidos pelas leis de direitos autorais e marcas comerciais aplicáveis.',
                                style: AppTheme.display4,
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
                            style: AppTheme.display6,
                            children: [
                              TextSpan(
                                  text:
                                      '\nÉ concedida permissão para baixar temporariamente uma cópia dos materiais (informações ou software) no Cuyuyu Entregas, apenas para visualização transitória pessoal e não comercial. Esta é a concessão de uma licença, não uma transferência de título e, sob esta licença, você não pode:',
                                  style: AppTheme.display4,
                                  children: [
                                    TextSpan(
                                      text:
                                          '\n\na)	Modificar ou copiar os materiais;             ',
                                      style: AppTheme.display4
                                          .copyWith(fontFamily: 'Muli'),
                                    ),
                                    TextSpan(
                                      text:
                                          '\n\nb)	Usar os materiais para qualquer finalidade comercial ou para exibição pública (comercial ou não comercial);             ',
                                      style: AppTheme.display4
                                          .copyWith(fontFamily: 'Muli'),
                                    ),
                                    TextSpan(
                                        text:
                                            '\n\nc)	Tentar descompilar ou fazer engenharia reversa de qualquer software contido no Cuyuyu Entregas;',
                                        style: AppTheme.display4
                                            .copyWith(fontFamily: 'Muli')),
                                    TextSpan(
                                      text:
                                          '\n\nd)	Remover quaisquer direitos autorais ou outras notações de propriedade dos materiais; ou',
                                      style: AppTheme.display4.copyWith(fontFamily: 'Muli')
                                    ),
                                    TextSpan(
                                      text:
                                          '\n\n e)	Transferir os materiais para outra pessoa ou \'espelhe\' os materiais em qualquer outro servidor.',
                                      style: AppTheme.display4.copyWith(fontFamily: 'Muli')
                                    ),
                                    TextSpan(
                                      text:
                                          '\n\nEsta licença será automaticamente rescindida se você violar alguma dessas restrições e poderá ser rescindida por Cuyuyu Entregas a qualquer momento. Ao encerrar a visualização desses materiais ou após o término desta licença, você deve apagar todos os materiais baixados em sua posse, seja em formato electrónico ou impresso.',
                                      style: AppTheme.display4
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
                            style: AppTheme.display6,
                            children: [
                              TextSpan(
                                text:
                                    '\nOs materiais no aplicativo Cuyuyu Entregas são fornecidos \'como estão\'. Cuyuyu Entregas não oferece garantias, expressas ou implícitas, e, por este meio, isenta e nega todas as outras garantias, incluindo, sem limitação, garantias implícitas ou condições de comercialização, adequação a um fim específico ou não violação de propriedade intelectual ou outra violação de direitos. Além disso, o Cuyuyu Entregas não garante ou faz qualquer representação relativa à precisão, aos resultados prováveis ou à confiabilidade do uso dos materiais em seu aplicativo ou de outra forma relacionado a esses materiais ou em sites vinculados a este aplicativo.',
                                style: AppTheme.display4
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
                            style: AppTheme.display6,
                            children: [
                              TextSpan(
                                text:
                                    '\nEm nenhum caso o Cuyuyu Entregas ou seus fornecedores serão responsáveis por quaisquer danos (incluindo, sem limitação, danos por perda de dados ou lucro ou devido a interrupção dos negócios) decorrentes do uso ou da incapacidade de usar os materiais em Cuyuyu Entregas, mesmo que Cuyuyu Entregas ou um representante autorizado da Cuyuyu Entregas tenha sido notificado oralmente ou por escrito da possibilidade de tais danos. Como algumas jurisdições não permitem limitações em garantias implícitas, ou limitações de responsabilidade por danos consequentes ou incidentais, essas limitações podem não se aplicar a você.',
                                style: AppTheme.display4
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
                            style: AppTheme.display6,
                            children: [
                              TextSpan(
                                text:
                                    '\nOs materiais exibidos no aplicativo da Cuyuyu Entregas podem incluir erros técnicos, tipográficos ou fotográficos. Cuyuyu Entregas não garante que qualquer material em seu aplicativo seja preciso, completo ou actual. Cuyuyu Entregas pode fazer alterações nos materiais contidos em seu aplicativo a qualquer momento, sem aviso prévio. No entanto, Cuyuyu Entregas não se compromete a actualizar os materiais.',
                                style: AppTheme.display4
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
                            style: AppTheme.display6,
                            children: [
                              TextSpan(
                                text:
                                    '\nO Cuyuyu Entregas não analisou todos os sites vinculados ao seu aplicativo e não é responsável pelo conteúdo de nenhum site vinculado. A inclusão de qualquer link não implica endosso por Cuyuyu Entregas. O uso de qualquer site vinculado é por conta e risco do usuário.',
                                style: AppTheme.display4
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
                            style: AppTheme.display6,
                            children: [
                              TextSpan(
                                text:
                                    '\nO Cuyuyu Entregas pode revisar estes termos de serviço do aplicativo a qualquer momento, sem aviso prévio. Ao usar este aplicativo, você concorda em ficar vinculado à versão actual desses termos de serviço.',
                                style: AppTheme.display4
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
                            style: AppTheme.display6,
                            children: [
                              TextSpan(
                                text:
                                    '\nEstes termos e condições são regidos e interpretados de acordo com as leis do Cuyuyu Entregas e você se submete irrevogavelmente à jurisdição exclusiva dos tribunais naquela localidade.',
                                style: AppTheme.display4
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
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
