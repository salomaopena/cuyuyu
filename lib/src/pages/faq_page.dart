import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/shop_app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FaqPage extends StatefulWidget {
  @override
  _FaqPageState createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
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
                            'Perguntas Frêquentes',
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
                                text: '1.	Como excluir a minha conta? \n',
                                style: AppTheme.textTheme.headline6
                                    .copyWith(color: AppTheme.darkerText),
                                children: [
                                  TextSpan(
                                    text:
                                        '\nSe você gostaria de acessar, corrígir, ou excluir quaisquer informações pessoais que temos sobre você, registe uma queixa, ou simplesmente peça mais informações de contacto a nossa equipe do Cuyuyu Entregas através do aplicativo.',
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
                                text:
                                    '2.	Qualquer pessoa pode receber o produto que eu comprei?\n',
                                style: AppTheme.textTheme.headline6
                                    .copyWith(color: AppTheme.darkerText),
                                children: [
                                  TextSpan(
                                    text:
                                        '\nSim, desde que seja maior de idade, esteja munido de um documento de identificação e assine o protocolo de entrega.',
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
                                text: '3.	Existe um valor mínimo de pedido?\n',
                                style: AppTheme.textTheme.headline6
                                    .copyWith(color: AppTheme.darkerText),
                                children: [
                                  TextSpan(
                                    text:
                                        '\nSim. Existem produtos com valor mínimo de pedido. Consulte a descrição do produto que desejar comprar.',
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
                                text:
                                    '4.	Posso alterar o endereço da entrega?\n',
                                style: AppTheme.textTheme.headline6
                                    .copyWith(color: AppTheme.darkerText),
                                children: [
                                  TextSpan(
                                      text:
                                          '\nSim, mas somente antes de concluir a Compra no Cuyuyu Entregas. Depois de finalizada, a Compra não pode mais ser alterada. Em caso de dúvida, entre em contacto com o CACE (Central de Atendimento Cuyuyu Entregas) por telefone',
                                      style: AppTheme.caption.copyWith(
                                        color: AppTheme.darkerText,
                                        letterSpacing: 1.5,
                                        fontStyle: FontStyle.normal,
                                      ),
                                      children: [
                                        TextSpan(
                                            text:
                                                ' +244 926542671 | +244 926682532',
                                            style: AppTheme.caption.copyWith(
                                              color: AppTheme.nearlyBlue,
                                              letterSpacing: 1.5,
                                              fontStyle: FontStyle.normal,
                                            )),
                                        TextSpan(
                                            text:
                                                ' ou pelos outros meios de atendimento disponibilizados como ',
                                            style: AppTheme.caption.copyWith(
                                              color: AppTheme.darkerText,
                                              letterSpacing: 1.5,
                                              fontStyle: FontStyle.normal,
                                            )),
                                        TextSpan(
                                            text:
                                                ' cuyuyu.entregras@outlook.com.',
                                            style: AppTheme.caption.copyWith(
                                              color: AppTheme.nearlyBlue,
                                              letterSpacing: 1.5,
                                              fontStyle: FontStyle.normal,
                                            ))
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
                                text:
                                    '5.	Como é calculado o frete para meu pedido?\n',
                                style: AppTheme.textTheme.headline6
                                    .copyWith(color: AppTheme.darkerText),
                                children: [
                                  TextSpan(
                                    text:
                                        '\nO valor do frete é calculado automaticamente, a partir dos produtos que o cliente vai seleccionando e da distância da entrega do cliente. A informação do valor do frete já calculado para determinado endereço e determinados produtos aparecem para o cliente no momento de finalização da compra na aplicação.',
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
                                text:
                                    '6.	Eu consigo mandar parte da compra para um endereço e outra parte para outro?\n',
                                style: AppTheme.textTheme.headline6
                                    .copyWith(color: AppTheme.darkerText),
                                children: [
                                  TextSpan(
                                    text:
                                        '\nNão. Todos os produtos adquiridos em determinada compra serão entregues conjuntamente, no mesmo endereço. Para enviar produtos para dois endereços diferentes, será necessário realizar duas Compras diferentes, em momentos distintivos. ',
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
                                text:
                                    '7.	Eu posso incluir ou excluir produtos do carrinho de compras?\n',
                                style: AppTheme.textTheme.headline6
                                    .copyWith(color: AppTheme.darkerText),
                                children: [
                                  TextSpan(
                                    text:
                                        '\nSim, desde que não finalize a compra no aplicativo. Para incluir, basta clicar no ícone do carrinho com sinal mais (+) e, para excluir, fazê-lo a partir da lista de compras. Para alterar a quantidade de produtos dentro do carrinho de compras é necessário que você clique em (+) para aumentar e (-) para diminuir.',
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
                                text:
                                    '8.	Posso abandonar ou retomar um carrinho de compras?\n',
                                style: AppTheme.textTheme.headline6
                                    .copyWith(color: AppTheme.darkerText),
                                children: [
                                  TextSpan(
                                    text:
                                        '\nSim, desde que os produtos nele indicado ainda estejam disponíveis em estoque e não finalize a compra, será possível recuperar o carrinho de compras e finalizar o pedido.',
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
                                text:
                                    '9.	Quais são as formas de pagamento disponíveis?\n',
                                style: AppTheme.textTheme.headline6
                                    .copyWith(color: AppTheme.darkerText),
                                children: [
                                  TextSpan(
                                    text:
                                        '\nNo momento, o Cuyuyu Entregas aceita apenas DINHEIRO A MÃO, TPA (Terminal de Pagamento Automático). No futuro, a Cuyuyu Entregas pretende adoptar outros meios de pagamento. Essas mudanças serão divulgadas em nosso aplicativo e reflectidas em nossa Política de Pagamentos.',
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
                  'FAQ',
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
