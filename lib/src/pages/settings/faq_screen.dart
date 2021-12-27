import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FaqScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'FAQ',
        style: TextStyle(
            color: AppColors.closeColor,
            fontSize: 18,
            fontWeight: FontWeight.w700),
      )),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          Text(
            'Perguntas Frêquentes',
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w700,
              fontSize: 16,

            ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(children: [
              TextSpan(
                  text: '1.	Como excluir a minha conta? \n',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                      color: Colors.black
                  ),
                  children: [
                    TextSpan(
                      text:
                          '\nSe você gostaria de acessar, corrígir, ou excluir quaisquer informações pessoais que temos sobre você, registe uma queixa, ou simplesmente peça mais informações de contacto a nossa equipe do Cuyuyu Entregas através do aplicativo.',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ]),
            ]),
          ),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(children: [
              TextSpan(
                  text:
                      '2.	Qualquer pessoa pode receber o produto que eu comprei?\n',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                      color: Colors.black
                  ),
                  children: [
                    TextSpan(
                      text:
                          '\nSim, desde que seja maior de idade, esteja munido de um documento de identificação e assine o protocolo de entrega.',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 1.2,
                        wordSpacing: 1.2,
                      ),
                    ),
                  ]),
            ]),
          ),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(children: [
              TextSpan(
                  text: '3.	Existe um valor mínimo de pedido?\n',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                      color: Colors.black
                  ),
                  children: [
                    TextSpan(
                      text:
                          '\nSim. Existem produtos com valor mínimo de pedido. Consulte a descrição do produto que desejar comprar.',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 1.2,
                        wordSpacing: 1.2,
                      ),
                    ),
                  ]),
            ]),
          ),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(children: [
              TextSpan(
                  text: '4.	Posso alterar o endereço da entrega?\n',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                      color: Colors.black
                  ),
                  children: [
                    TextSpan(
                        text:
                            '\nSim, mas somente antes de concluir a Compra no Cuyuyu Entregas. Depois de finalizada, a Compra não pode mais ser alterada. Em caso de dúvida, entre em contacto com o CACE (Central de Atendimento Cuyuyu Entregas) por telefone',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          height: 1.2,
                          wordSpacing: 1.2,
                        ),
                        children: [
                          TextSpan(
                            text: ' +244 926542671 | +244 926682532',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              height: 1.2,
                              wordSpacing: 1.2,
                            ),
                          ),
                          TextSpan(
                            text:
                                ' ou pelos outros meios de atendimento disponibilizados como ',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              height: 1.2,
                              wordSpacing: 1.2,
                            ),
                          ),
                          TextSpan(
                            text: ' cuyuyu.entregras@outlook.com.',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                height: 1.2,
                                wordSpacing: 1.2,
                                color: Colors.blue),
                          )
                        ]),
                  ]),
            ]),
          ),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(children: [
              TextSpan(
                  text: '5.	Como é calculado o frete para meu pedido?\n',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                      color: Colors.black
                  ),
                  children: [
                    TextSpan(
                      text:
                          '\nO valor do frete é calculado automaticamente, a partir dos produtos que o cliente vai seleccionando e da distância da entrega do cliente. A informação do valor do frete já calculado para determinado endereço e determinados produtos aparecem para o cliente no momento de finalização da compra na aplicação.',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 1.2,
                        wordSpacing: 1.2,
                      ),
                    ),
                  ]),
            ]),
          ),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(children: [
              TextSpan(
                  text:
                      '6.	Eu consigo mandar parte da compra para um endereço e outra parte para outro?\n',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                      color: Colors.black
                  ),
                  children: [
                    TextSpan(
                      text:
                          '\nNão. Todos os produtos adquiridos em determinada compra serão entregues conjuntamente, no mesmo endereço. Para enviar produtos para dois endereços diferentes, será necessário realizar duas Compras diferentes, em momentos distintivos. ',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 1.2,
                        wordSpacing: 1.2,
                      ),
                    ),
                  ]),
            ]),
          ),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(children: [
              TextSpan(
                  text:
                      '7.	Eu posso incluir ou excluir produtos do carrinho de compras?\n',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                      color: Colors.black
                  ),
                  children: [
                    TextSpan(
                      text:
                          '\nSim, desde que não finalize a compra no aplicativo. Para incluir, basta clicar no ícone do carrinho com sinal mais (+) e, para excluir, fazê-lo a partir da lista de compras. Para alterar a quantidade de produtos dentro do carrinho de compras é necessário que você clique em (+) para aumentar e (-) para diminuir.',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 1.2,
                        wordSpacing: 1.2,
                      ),
                    ),
                  ]),
            ]),
          ),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(children: [
              TextSpan(
                  text:
                      '8.	Posso abandonar ou retomar um carrinho de compras?\n',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                      color: Colors.black
                  ),
                  children: [
                    TextSpan(
                      text:
                          '\nSim, desde que os produtos nele indicado ainda estejam disponíveis em estoque e não finalize a compra, será possível recuperar o carrinho de compras e finalizar o pedido.',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 1.2,
                        wordSpacing: 1.2,
                      ),
                    ),
                  ]),
            ]),
          ),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(children: [
              TextSpan(
                  text: '9.	Quais são as formas de pagamento disponíveis?\n',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                      color: Colors.black
                  ),
                  children: [
                    TextSpan(
                      text:
                          '\nNo momento, o Cuyuyu Entregas aceita apenas DINHEIRO A MÃO, TPA (Terminal de Pagamento Automático). No futuro, a Cuyuyu Entregas pretende adoptar outros meios de pagamento. Essas mudanças serão divulgadas em nosso aplicativo e reflectidas em nossa Política de Pagamentos.',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 1.2,
                        wordSpacing: 1.2,
                      ),
                    ),
                  ]),
            ]),
          ),
        ],
      ),
    );
  }
}
