import 'package:cuyuyu/src/components/bottom_nav_bar.dart';
import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FaqPage extends StatefulWidget {
  @override
  _FaqPageState createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQ", style: AppTheme.title),
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
                        'Perguntas Frêquentes',
                        style: AppTheme.display6,
                        overflow: TextOverflow.ellipsis,
                      )),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(children: [
                        TextSpan(
                            text: '1.	Como excluir a minha conta? \n',
                            style: AppTheme.display6,
                            children: [
                              TextSpan(
                                text:
                                    '\nSe você gostaria de acessar, corrígir, ou excluir quaisquer informações pessoais que temos sobre você, registe uma queixa, ou simplesmente peça mais informações de contacto a nossa equipe do Cuyuyu Entregas através do aplicativo.',
                                style: AppTheme.display4),
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
                            style: AppTheme.display6,
                            children: [
                              TextSpan(
                                text:
                                    '\nSim, desde que seja maior de idade, esteja munido de um documento de identificação e assine o protocolo de entrega.',
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
                            text: '3.	Existe um valor mínimo de pedido?\n',
                            style: AppTheme.display6,
                            children: [
                              TextSpan(
                                text:
                                    '\nSim. Existem produtos com valor mínimo de pedido. Consulte a descrição do produto que desejar comprar.',
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
                            text: '4.	Posso alterar o endereço da entrega?\n',
                            style: AppTheme.display6,
                            children: [
                              TextSpan(
                                  text:
                                      '\nSim, mas somente antes de concluir a Compra no Cuyuyu Entregas. Depois de finalizada, a Compra não pode mais ser alterada. Em caso de dúvida, entre em contacto com o CACE (Central de Atendimento Cuyuyu Entregas) por telefone',
                                  style: AppTheme.display4,
                                  children: [
                                    TextSpan(
                                        text:
                                            ' +244 926542671 | +244 926682532',
                                        style: AppTheme.display4.copyWith(
                                          color: AppTheme.nearlyBlue,
                                            fontFamily: 'Muli',
                                        )),
                                    TextSpan(
                                        text:
                                            ' ou pelos outros meios de atendimento disponibilizados como ',
                                        style: AppTheme.display4),
                                    TextSpan(
                                        text: ' cuyuyu.entregras@outlook.com.',
                                        style: AppTheme.display4.copyWith(
                                          color: AppTheme.nearlyBlue,
                                        fontFamily: 'Muli'),)
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
                            style: AppTheme.display6,
                            children: [
                              TextSpan(
                                text:
                                    '\nO valor do frete é calculado automaticamente, a partir dos produtos que o cliente vai seleccionando e da distância da entrega do cliente. A informação do valor do frete já calculado para determinado endereço e determinados produtos aparecem para o cliente no momento de finalização da compra na aplicação.',
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
                            text:
                                '6.	Eu consigo mandar parte da compra para um endereço e outra parte para outro?\n',
                            style: AppTheme.display6,
                            children: [
                              TextSpan(
                                text:
                                    '\nNão. Todos os produtos adquiridos em determinada compra serão entregues conjuntamente, no mesmo endereço. Para enviar produtos para dois endereços diferentes, será necessário realizar duas Compras diferentes, em momentos distintivos. ',
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
                            text:
                                '7.	Eu posso incluir ou excluir produtos do carrinho de compras?\n',
                            style: AppTheme.display6,
                            children: [
                              TextSpan(
                                text:
                                    '\nSim, desde que não finalize a compra no aplicativo. Para incluir, basta clicar no ícone do carrinho com sinal mais (+) e, para excluir, fazê-lo a partir da lista de compras. Para alterar a quantidade de produtos dentro do carrinho de compras é necessário que você clique em (+) para aumentar e (-) para diminuir.',
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
                            text:
                                '8.	Posso abandonar ou retomar um carrinho de compras?\n',
                            style: AppTheme.display6,
                            children: [
                              TextSpan(
                                text:
                                    '\nSim, desde que os produtos nele indicado ainda estejam disponíveis em estoque e não finalize a compra, será possível recuperar o carrinho de compras e finalizar o pedido.',
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
                            text:
                                '9.	Quais são as formas de pagamento disponíveis?\n',
                            style: AppTheme.display6,
                            children: [
                              TextSpan(
                                text:
                                    '\nNo momento, o Cuyuyu Entregas aceita apenas DINHEIRO A MÃO, TPA (Terminal de Pagamento Automático). No futuro, a Cuyuyu Entregas pretende adoptar outros meios de pagamento. Essas mudanças serão divulgadas em nosso aplicativo e reflectidas em nossa Política de Pagamentos.',
                                style: AppTheme.display4,
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
