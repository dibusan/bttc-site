class VisitorsController < ApplicationController
  def home
    @sponsors = [
      {
        name: 'ITTF',
        url: 'https://www.ittf.com/',
        image: 'sponsor-ittf'
      },{
        name: 'USTTA',
        url: 'https://www.teamusa.org/USA-Table-Tennis',
        image: 'sponsor-ustta'
      },{
        name: 'ULTM',
        url: 'http://ultm.org/',
        image: 'sponsor-ultm'
      },{
        name: 'Butterfly',
        url: 'https://butterflyonline.com/',
        image: 'butterfly-logo'
      },{
        name: 'Newgy',
        url: 'https://www.newgy.com/',
        image: 'sponsor-newgy'
      },{
        name: 'Paddle Palace',
        url: 'https://www.paddlepalace.com/',
        image: 'sponsor-paddlepalace'
      },{
        name: 'Fort Lauderdale convention center',
        url: 'https://www.ftlauderdalecc.com/',
        image: 'sponsor-ftlauderdaleconvcenter'
      }

    ]
  end
end
