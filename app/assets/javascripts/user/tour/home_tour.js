var tourHome = {
  id: "photo-upload-link-header",
  i18n: {
    nextBtn: "Avançar",
    prevBtn: "Voltar",
    doneBtn: "Concluir",
    skipBtn: "Cancelar",
    closeTooltip: "Fechar",
    stepNums : ["1", "2", "3"]
  },
  onEnd: function() {
    ShowCommunication();
  },
  onClose: function() {
    ShowCommunication();
  },
  steps: [
    {
      title: "Poste suas fotos",
      content: "Envie suas fotos clicando aqui. Ela será publicada e você começará a se destacar.",
      target: "photo-upload-link-header",
      placement: "bottom",
      xOffset: "-200",
      yOffset: "-18",
      arrowOffset: "200",
      width: "250"
    },
    {
      title: "Suas Experiências",
      content: "Visualize o seu nível de experiência no Pic2Gether. Lembre-se, quanto mais você participar, mais experiência e destaque você terá.",
      target: "user-experience",
      placement: "right",
      xOffset: "0",
      yOffset: "18",
      arrowOffset: "0",
      width: "250"
    },    
    {
      title: "Ranking",
      content: "Aqui será possível acompanhar a evolução dos fotógrafos que mais se destacam no Pic2Gether. Não fique para traz, comece agora mesmo postando suas fotos, curtindo, compartilhando e ganhe experiências e destaque global.",
      target: "user-ranking",
      placement: "right",
      xOffset: "0",
      yOffset: "18",
      arrowOffset: "0",
      width: "250"
    },        
    {
      title: "Redes Sociais",
      content: "Compartilhe o Pic2Gether nas suas redes sociais e convide os seus amigos. Ao compartilhar pela primeira vez em cada uma das redes sociais (somente através do link ao lado), você ganhará o direito de postar mais uma foto por dia. Atualmente você tem apenas 1(uma) postagem diária.",
      target: "social-network-share",
      placement: "left",
      xOffset: "-12",
    }
  ]
};