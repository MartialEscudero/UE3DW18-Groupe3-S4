<?php

namespace Watson\Controller;

use Silex\Application;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

class HomeController {

    /**
     * Home page controller.
     *
     * @param Application $app Silex application
     */
    public function indexAction(?string $n, Request $request, Application $app) {
        // Throw 404 if not a number
        if(!is_numeric(filter_var($n, FILTER_SANITIZE_NUMBER_INT)) && !is_null($n)){
            throw new \Exception("Not found", 404);        
        }

        //the total number of links
        $linkNumber = $links = $app['dao.link']->findNumberLinks();
        //round up the division to get the number of page
        $nbPages = ceil($linkNumber/6);

        //Render a page of 6 links
        if(!is_null($n)){
            $links = $app['dao.link']->findAllPage((int) $n);

            //Trow 404 error if the result from database is empty
            if(empty($links))
                throw new \Exception("No link found", 404);
                
            return $app['twig']->render('index.html.twig', array(
                'links' => $links,
                'linkNumber' => $linkNumber,
                'currentPage' => $n,
                'nbPages' => $nbPages
            ));
        }

        //The homepage return the last 6 links
        $links = $app['dao.link']->findAllPage(0);
        return $app['twig']->render('index.html.twig', array(
            'links' => $links,
            'currentPage' => 1,
            'linkNumber' => $linkNumber,
            'nbPages' => $nbPages
        ));
    }

    /**
     * Link details controller.
     *
     * @param integer $id Link id
     * @param Request $request Incoming request
     * @param Application $app Silex application
     */
    public function linkAction($id, Request $request, Application $app) {
        $link = $app['dao.link']->find($id);
        if ($app['security.authorization_checker']->isGranted('IS_AUTHENTICATED_FULLY')) {
            // A user is fully authenticated : he can add comments
            // Check if he's author for manage link

        }
        return $app['twig']->render('link.html.twig', array(
            'link' => $link
        ));
    }

    /**
     * Links by tag controller.
     *
     * @param integer $id Tag id
     * @param Request $request Incoming request
     * @param Application $app Silex application
     */
    public function tagAction($id, Request $request, Application $app) {
        $links = $app['dao.link']->findAllByTag($id);
        $tag   = $app['dao.tag']->findTagName($id);

        return $app['twig']->render('result_tag.html.twig', array(
            'links' => $links,
            'tag'   => $tag
        ));
    }

    /**
     * User login controller.
     *
     * @param Request $request Incoming request
     * @param Application $app Silex application
     */
    public function loginAction(Request $request, Application $app) {
        return $app['twig']->render('login.html.twig', array(
            'error'         => $app['security.last_error']($request),
            'last_username' => $app['session']->get('_security.last_username'),
            )
        );
    }

     /**
     * Rss feed
     *
     * @param Request $request Incoming request
     * @param Application $app Silex application
     */
    public function rssFeedAction(?string $number, Request $request, Application $app) {
        // Throw 404 if not a number
        if(!is_numeric(filter_var($number, FILTER_SANITIZE_NUMBER_INT)) && !is_null($number)){
            throw new \Exception("Not found", 404);        
        }

        //build the rss text
        $rss = $app['dao.rss']->getRSS($number);

        $rssText = $app['twig']->render('feed.rss.twig', array(
            'rss' => $rss
        ));

        //Create a http response
        $response = new Response();
        $response->headers->set("Content-type", "text/xml");
        //set status code and the rss text
        $response->setStatusCode(Response::HTTP_OK);
        $response->setContent($rssText);
        
        return $response;
    }
}
