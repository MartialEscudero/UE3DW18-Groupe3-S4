<?php

namespace Watson\DAO;

use Watson\Domain\Rss;

class RssDAO extends DAO
{
    private $linkDAO;

    public function setLinkDAO($linkDAO) {
        $this->linkDAO = $linkDAO;
    }

    /**
     * Create the text file for the rss feed
     * 
     * @return string
     */
    public function getRSS($number) {
        //retrieve the number of links asked or 15 by default
        $links = is_null($number) ? $this->linkDAO->findLastLinks("15") : $this->linkDAO->findLastLinks($number);

        if(!empty($links)){
           //build the rss object 
            $rss = $this->buildDomainObject($links);
        } else {
            //throw exception if no link where found
            throw new \Exception('No link to display.', 503);
        }

        return $rss;
    }

     /**
     * Creates a Rss object based on a DB rows.
     *
     * @param array $row The DB row(s) containing link data.
     * @return \Watson\Domain\Rss
     */
    protected function buildDomainObject($row)
    {
        $rss = new Rss();
        //Set rss parameters and data
        $rss->setTitle("Watson")
            ->setDescription("L'application qui regroupe les meilleurs liens du web")
            ->setHomeURL("http://localhost:8080")
            ->setLinks($row);

        return $rss;
    }
}
