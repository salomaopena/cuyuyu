import 'package:cuyuyu/src/utils/app_theme.dart';
import 'package:cuyuyu/src/utils/shop_app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrivacyPage extends StatefulWidget {
  @override
  _PrivacyPageState createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
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
                            'Política Privacidade',
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
                                text: 'Última actualização, Setembro de 2020\n',
                                style: AppTheme.textTheme.headline6
                                    .copyWith(color: AppTheme.darkerText),
                                children: [
                                  TextSpan(
                                    text:
                                        '\nA sua privacidade é importante para nós. É política do Cuyuyu Entregas respeitar a sua privacidade em relação a qualquer informação sua que possamos colectar na nossa aplicação Cuyuyu Entregas, e outras aplicações que possuímos e operamos.',
                                    style: AppTheme.caption.copyWith(
                                      color: AppTheme.darkerText,
                                      letterSpacing: 1.5,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '\n\nSolicitamos informações pessoais apenas quando realmente precisamos delas para lhe fornecer um serviço. Fazemo-lo por meios justos e legais, com o seu conhecimento e consentimento. Também informamos por que estamos colectando e como será usado.',
                                    style: AppTheme.caption.copyWith(
                                      color: AppTheme.darkerText,
                                      letterSpacing: 1.5,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '\n\nApenas retemos as informações colectadas pelo tempo necessário para fornecer o serviço solicitado. Quando armazenamos dados, protegemos dentro de meios comercialmente aceitáveis para evitar perdas e roubos, bem como acesso, divulgação, cópia, uso ou modificação não autorizadas.',
                                    style: AppTheme.caption.copyWith(
                                      color: AppTheme.darkerText,
                                      letterSpacing: 1.5,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '\n\nNão compartilhamos informações de identificação pessoal publicamente ou com terceiros, excepto quando exigido por lei.',
                                    style: AppTheme.caption.copyWith(
                                      color: AppTheme.darkerText,
                                      letterSpacing: 1.5,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '\n\nTodas as informações pessoais de membros, assinantes, clientes ou visitantes que usem o Cuyuyu Entregas serão tratados em concordância com a Lei da Protecção de dados Pessoais de 29 de Dezembro de 2011 (Lei nº 2) do Diário da República nº 2 do artigo 165º e da alínea d) do nº 2 do artigo 166º.',
                                    style: AppTheme.caption.copyWith(
                                      color: AppTheme.darkerText,
                                      letterSpacing: 1.5,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '\n\nO nosso aplicativo pode ter ligações (links) para sites externos que não são operados por nós. Esteja ciente de que não temos controlo sobre o conteúdo e práticas desses sites e não podemos aceitar responsabilidade por suas respectivas políticas de privacidade.',
                                    style: AppTheme.caption.copyWith(
                                      color: AppTheme.darkerText,
                                      letterSpacing: 1.5,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '\n\nVocê é livre para recusar a nossa solicitação de informações pessoais, entendendo que talvez não possamos fornecer alguns dos serviços desejados.',
                                    style: AppTheme.caption.copyWith(
                                      color: AppTheme.darkerText,
                                      letterSpacing: 1.5,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '\n\nO uso continuado de nosso aplicativo será considerado como aceitação de nossas práticas em torno de privacidade e informações pessoais. Se você tiver alguma dúvida sobre como lidamos com dados do usuário e informações pessoais, entre em contacto connosco.',
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
                                text: 'Tipos de Dados colectados\n',
                                style: AppTheme.textTheme.headline6
                                    .copyWith(color: AppTheme.darkerText),
                                children: [
                                  TextSpan(
                                    text:
                                        '\nEntre os tipos de Dados Pessoais que este Aplicativo colecta, por si mesmo ou através de terceiros, existem: Dados de uso; nome; sobrenome; posição geográfica; e-mail; senha; imagem; Cookie; nome de usuário.'
                                        '\n\nDetalhes completos sobre cada tipo de Dados Pessoais colectados são fornecidos nas seções dedicadas desta política de privacidade ou por textos explicativos específicos exibidos antes da colecta de Dados.'
                                        '\n\nOs Dados Pessoais poderão ser fornecidos livremente pelo Usuário, ou, no caso dos Dados de Utilização, colectados automaticamente ao se utilizar este Aplicativo.'
                                        '\n\nA menos que especificado diferentemente todos os Dados solicitados por este Aplicativo são obrigatórios e a falta de fornecimento destes Dados poderá impossibilitar este Aplicativo de fornecer os seus Serviços.'
                                        '\n\nNos casos em que este Aplicativo afirmar especificamente que alguns Dados não forem obrigatórios, os Usuários ficam livres para deixarem de comunicar estes Dados sem nenhuma consequência para a disponibilidade ou o funcionamento do Serviço.'
                                        '\n\nOs Usuários que tiverem dúvidas a respeito de quais Dados Pessoais são obrigatórios estão convidados a entrar em contacto com o Proprietário.'
                                        '\n\nOs Usuários ficam responsáveis por quaisquer Dados Pessoais de terceiros que forem obtidos, publicados ou compartilhados através deste Serviço (este Aplicativo) e confirmam que possuem a autorização dos terceiros para fornecerem os Dados para o Proprietário.',
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
                                text: 'Política de Cookies Cuyuyu Entregas\n',
                                style: AppTheme.textTheme.headline6
                                    .copyWith(color: AppTheme.darkerText),
                                children: [
                                  TextSpan(
                                      text: '\nO que são cookies?\n',
                                      style: AppTheme.textTheme.headline6
                                          .copyWith(
                                              color: AppTheme.darkerText)),
                                  TextSpan(
                                    text:
                                        '\nComo é prática comum em quase todos os aplicativos ou sites profissionais, este aplicativo usa cookies, que são pequenos arquivos baixados no seu dispositivo, para melhorar sua experiência. Esta página descreve quais informações eles colectam, como as que usamos e por que às vezes precisamos armazenar esses cookies. Também compartilharemos como você pode impedir que esses cookies sejam armazenados, no entanto, isso pode fazer o downgrade ou \'quebrar\' certos elementos da funcionalidade do aplicativo.',
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
                                text: 'Como usamos os cookies?\n',
                                style: AppTheme.textTheme.headline6
                                    .copyWith(color: AppTheme.darkerText),
                                children: [
                                  TextSpan(
                                    text:
                                        '\nUtilizamos cookies por vários motivos, detalhados abaixo. Infelizmente, na maioria dos casos, não existem opções padrão do sector para desactivar os cookies sem desactivar completamente a funcionalidade e os recursos que eles adicionam a este aplicativo. É recomendável que você deixe todos os cookies se não tiver certeza se precisa ou não deles, caso sejam usados para fornecer um serviço que você usa.'
                                        '\n\nQuaisquer usos de cookies – ou de outras ferramentas de rastreamento – por este Aplicativo ou pelos proprietários de serviços terceiros utilizados por este Aplicativo serão para a finalidade de fornecer os Serviços solicitados pelo Usuário, além das demais finalidades descritas no presente documento e na Política de Cookies, se estiver disponível.',
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
                                text: 'Desactivar cookies\n',
                                style: AppTheme.textTheme.headline6
                                    .copyWith(color: AppTheme.darkerText),
                                children: [
                                  TextSpan(
                                    text:
                                        '\nVocê pode impedir a configuração de cookies ajustando as configurações do seu navegador (consulte a Ajuda do navegador para saber como fazer isso em caso de ser redireccionado para um browser). Esteja ciente de que a desativação de cookies afectará a funcionalidade deste aplicativo e de muitos outros sites externos que  você visita. A desativação de cookies geralmente resultará na desativação de determinadas funcionalidades e recursos deste aplicativo. Portanto, é recomendável que você não desactive os cookies.',
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
                                text: 'Cookies que definimos\n',
                                style: AppTheme.textTheme.headline6
                                    .copyWith(color: AppTheme.darkerText),
                                children: [
                                  TextSpan(
                                      text: '\nCookies relacionados à conta\n',
                                      style: AppTheme.textTheme.headline6
                                          .copyWith(
                                              color: AppTheme.darkerText)),
                                  TextSpan(
                                    text:
                                        '\nSe você criar uma conta connosco no Cuyuyu Entregas, usaremos cookies para a gestão do processo de inscrição e administração geral. Esses cookies geralmente serão excluídos quando você sair do sistema, porém, em alguns casos, eles poderão permanecer posteriormente para lembrar as suas preferências ao sair ou terminar sessão no aplicativo.',
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
                                    'Cookies relacionados ao login ou iniciar sessão\n',
                                style: AppTheme.textTheme.headline6
                                    .copyWith(color: AppTheme.darkerText),
                                children: [
                                  TextSpan(
                                    text:
                                        '\nUtilizamos cookies quando você está logado, para que possamos lembrar dessa acção. Isso evita que você precise fazer login sempre que visitar os serviços de uma tela da aplicação. Esses cookies são normalmente removidos ou limpados quando você efectua logout/terminar sessão para garantir que você possa aceder apenas a recursos e áreas restritas ao efectuar login.',
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
                                    'Cookies relacionados a boletins por e-mail \n',
                                style: AppTheme.textTheme.headline6
                                    .copyWith(color: AppTheme.darkerText),
                                children: [
                                  TextSpan(
                                    text:
                                        '\nEste aplicativo oferece serviços de assinatura de boletim informativo ou e-mail e os cookies podem ser usados para lembrar se você já está registado e se deve mostrar determinadas notificações  válidas apenas para usuários inscritos / não inscritos.',
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
                                    'Pedidos processando cookies relacionados\n',
                                style: AppTheme.textTheme.headline6
                                    .copyWith(color: AppTheme.darkerText),
                                children: [
                                  TextSpan(
                                    text:
                                        '\nEste aplicativo oferece facilidades de comércio electrónico ou pagamento e alguns cookies são essenciais para garantir que seu pedido seja lembrado entre as telas, para que possamos processá-lo adequadamente.',
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
                                text: 'Cookies relacionados a pesquisas\n',
                                style: AppTheme.textTheme.headline6
                                    .copyWith(color: AppTheme.darkerText),
                                children: [
                                  TextSpan(
                                    text:
                                        '\nPeriodicamente, oferecemos pesquisas e questionários para fornecer informações interessantes, ferramentas úteis ou para entender nossa base de usuários com mais precisão. Essas pesquisas podem usar cookies para lembrar quem já participou numa pesquisa ou para fornecer resultados precisos após a alteração das páginas.',
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
                                text: 'Cookies relacionados a formulários\n',
                                style: AppTheme.textTheme.headline6
                                    .copyWith(color: AppTheme.darkerText),
                                children: [
                                  TextSpan(
                                    text:
                                        '\nQuando você envia dados por meio de um formulário como os encontrados nas páginas/telas de contacto ou nos formulários de comentários, os cookies podem ser configurados para lembrar os detalhes do usuário para correspondência futura.',
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
                                text: 'Cookies de preferências do aplicativo\n',
                                style: AppTheme.textTheme.headline6
                                    .copyWith(color: AppTheme.darkerText),
                                children: [
                                  TextSpan(
                                    text:
                                        '\nPara proporcionar uma óptima experiência neste aplicativo, fornecemos a funcionalidade para definir suas preferências de como esse aplicativo é executado quando você o usa. Para lembrar suas preferências, precisamos definir cookies para que essas informações possam ser chamadas sempre que você interagir com uma página/tela for afectada por suas preferências.',
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
                                text: 'Cookies de Terceiros\n',
                                style: AppTheme.textTheme.headline6
                                    .copyWith(color: AppTheme.darkerText),
                                children: [
                                  TextSpan(
                                    text:
                                        '\nEm alguns casos especiais, também usamos cookies fornecidos por terceiros confiáveis. A seção a seguir detalha quais cookies de terceiros você pode encontrar através deste aplicativo. Este aplicativo usa o Google Analytics, que é uma das soluções de análise mais difundidas e confiáveis da Web, para nos ajudar a entender como você usa o aplicativo e como podemos melhorar sua experiência.'
                                        '\n\nEsses cookies podem rastrear itens como quanto tempo você gasta no aplicativo e as páginas visitadas, para que possamos continuar produzindo conteúdo atraente. Para mais informações sobre cookies do Google Analytics, consulte a página oficial do Google Analytics.'
                                        '\n\nAs análises de terceiros são usadas para rastrear e medir o uso deste aplicativo, para que possamos continuar produzindo conteúdo atractivo. Esses cookies podem rastrear itens como o tempo que você passa no aplicativo ou as páginas telas visitadas, o que nos ajuda a entender como podemos melhorar o aplicativo para você.'
                                        '\n\nPeriodicamente, testamos novos recursos e fazemos alterações subtis na maneira como o aplicativo se apresenta. Quando ainda estamos testando novos recursos, esses cookies podem ser usados para garantir que você receba uma experiência consistente enquanto estiver no aplicativo, enquanto entendemos quais optimizações os nossos usuários mais apreciam.'
                                        '\n\nÀ medida que vendemos produtos, é importante entendermos as estatísticas sobre quantos visitantes de nosso aplicativo realmente compram e, portanto, esse é o tipo de dados que esses cookies rastrearão. Isso é importante para você, pois significa que podemos fazer previsões de negócios com precisão que nos permitem analisar nossos custos de publicidade e produtos para garantir o melhor preço possível.',
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
                                text: 'Mais informações\n',
                                style: AppTheme.textTheme.headline6
                                    .copyWith(color: AppTheme.darkerText),
                                children: [
                                  TextSpan(
                                    text:
                                        '\nEsperemos que esteja esclarecido e, como mencionado anteriormente, se houver algo que você não tem certeza se precisa ou não, geralmente é mais seguro deixar os cookies activados, caso interaja com um dos recursos que você usa em nosso site.'
                                        '\n\nEsta política é efectiva a partir de Setembro de 2020.',
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
              width: AppBar().preferredSize.height + 10,
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
                  'Política Privacidade',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    fontFamily: 'Raleway',
                  ),
                  overflow: TextOverflow.ellipsis,
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
