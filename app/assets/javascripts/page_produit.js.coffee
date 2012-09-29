$(document).ready(()->
    function_filter_produit =
        init:()->
            this.event()
        event:()->
            that = this
            $('.filter_zone>ul>li').each(()->
                $(this).on('click',()->
                    if $(this).hasClass('is_click')
                        $(this).removeClass('is_click')
                    else
                        $(this).addClass('is_click')
                    all_categorie = that.get_categorie_clicked()
                    that.get_categorie(all_categorie)
                )
            )
        get_categorie_clicked:()->
            categorie_id = []
            $('.filter_zone>ul>li').each(()->
                if $(this).hasClass('is_click')
                    categorie_id.push($(this).attr('data-id'))
            )

            categorie_id
        get_categorie:(categorie_id)->
            xhr = new XMLHttpRequest()
            xhr.open('POST','/page_produit/index/categorie')
            xhr.setRequestHeader('Accept','application/json')

            form = new FormData()

            for champ, valeur of categorie_id
                form.append('categorie_id[]',valeur)

            xhr.send(form)

            xhr.onreadystatechange = ()->
                if xhr.readyState == xhr.DONE
                    console.log('test')
                    console.log(xhr.responseText)
                    ancienne_list = $('.l_product_list')
                    ancienne_list.before(xhr.responseText)
                    ancienne_list.remove()
                    

    function_filter_produit.init()

)
